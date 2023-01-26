//
//  Dispatcher.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation
import OSLog

/// Error that occurs while dispatching an HTTP network request.
enum Error: Swift.Error {
    
    case generic(Swift.Error?)
    case invalidHTTPCode(Int)
    case noData
    case unableToDecode(Swift.Error?)
}

/// Provides a blueprint of a dispatchable network operation.
protocol Dispatchable {
    
    /// Sends a network request to the provided endpoint.
    func execute<T: Decodable>(_ endpoint: Endpoint,
                               completion: @escaping (Result<T, Error>) -> Void)
    
    /// Cancels a network request.
    func cancel()
}

/// Allows to send an HTTP network request and decode the result.
class Dispatcher: Dispatchable {
    
    static let shared = Dispatcher()
    
    private var dataTask: URLSessionTask?
    
    private init() {
        // No-op
    }
    
    private func buildRequest(for endpoint: Endpoint) -> URLRequest {
        let request = NSMutableURLRequest(url: endpoint.url,
                                          cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                          timeoutInterval: endpoint.timeoutInterval)
        
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        return request as URLRequest
    }
    
    func execute<T: Decodable>(_ endpoint: Endpoint,
                               completion: @escaping (Result<T, Error>) -> Void) {
        let request = buildRequest(for: endpoint)
        
        dataTask = URLSession.default.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    os_log("Failed to load URL %@ with error: %@",
                           log: OSLog.network,
                           type: .error,
                           request.url?.absoluteString ?? "invalid",
                           error.localizedDescription)
                    
                    completion(.failure(.generic(error)))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse,
                   !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(.invalidHTTPCode(httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
#if DEBUG
                // For convenience during debugging, log JSON data in case if it's possible to
                // serialize it.
                if let json = try? JSONSerialization.jsonObject(with: data,
                                                                options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json,
                                                              options: .prettyPrinted) {
                    os_log("JSON: %@",
                           log: OSLog.network,
                           type: .debug,
                           String(decoding: jsonData, as: UTF8.self))
                }
#endif
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.unableToDecode(error)))
                }
            }
        })
        
        dataTask?.resume()
    }
    
    func cancel() {
        dataTask?.cancel()
    }
}
