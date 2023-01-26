//
//  URLSession.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation

extension URLSession {
    
    static var `default`: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfiguration.urlCache = nil
        
        return URLSession(configuration: sessionConfiguration)
    }
}
