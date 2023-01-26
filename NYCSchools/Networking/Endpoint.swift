//
//  Endpoint.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation

/// HTTP Headers that are used in `Enpoint`.
typealias HTTPHeaders = [String: String]

/// HTTP method supported by the `Dispatcher`.
/// NOTE: For simplicity only `HTTPMethod.get` is supported.
enum HTTPMethod: String {
    
    case get = "GET"
}

/// Endpoint, that contains information, which will be used by the `Dispatcher` to execute a
/// network request.
protocol Endpoint {
    
    /// URL of the `Endpoint`.
    var url: URL { get }
    
    /// HTTP method.
    var method: HTTPMethod { get }
    
    /// HTTP headers.
    var headers: HTTPHeaders { get }
    
    /// Timeout interval that specifies the limit on the idle interval allotted to a request
    /// in the process of loading.
    var timeoutInterval: TimeInterval { get }
}
