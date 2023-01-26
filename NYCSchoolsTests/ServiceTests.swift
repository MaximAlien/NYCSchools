//
//  ServiceTests.swift
//  NYCSchoolsTests
//
//  Created by Maxim Makhun on 24.01.2023.
//

import XCTest
@testable import NYCSchools

class EnpointMock: Endpoint {
    
    var url: URL = URL(string: "https://valid_url.com")!
    
    var method: HTTPMethod = .get
    
    var headers: HTTPHeaders = [:]
    
    var timeoutInterval: TimeInterval = 1.0
}

struct ResponseMock: Decodable {
    
    var response: String
}

class DispatcherMock: Dispatchable {
    
    func execute<T>(_ endpoint: Endpoint,
                    completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let responseMock = ResponseMock(response: "response")
        completion(.success(responseMock as! T))
    }
    
    func cancel() {
        // No-op
    }
}

class ServiceMock: Service {
    
    var dispatchable: Dispatchable
    
    init(_ dispatcherMock: DispatcherMock) {
        self.dispatchable = dispatcherMock
    }
    
    func dispatch(_ endpoint: Endpoint,
                  completion: @escaping (Result<ResponseMock, Error>) -> Void) {
        guard let dispatcherMock = dispatchable as? DispatcherMock else {
            XCTFail("Unexpected type.")
            return
        }
        
        dispatcherMock.execute(endpoint,
                               completion: completion)
    }
}

class ServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testService() {
        let dispatcherMock = DispatcherMock()
        let serviceMock = ServiceMock(dispatcherMock)
        let endpointMock = EnpointMock()
        
        let expectation = expectation(description: "Expectation.")
        serviceMock.dispatch(endpointMock) { result in
            switch result {
            case .success(let responseMock):
                XCTAssertEqual(responseMock.response, "response")
            case .failure(_):
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
