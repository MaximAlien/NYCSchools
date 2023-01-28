//
//  NYCOpenDataSchoolsEndpoint.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation

enum OpenDataEndpoint {
    
    case schools(_ limit: UInt, offset: UInt)
    
    case schoolResults(_ districtBoroughNumber: String)
}

extension OpenDataEndpoint: Endpoint {
    
    var url: URL {
        var urlComponents = URLComponents()
        // Based on staging and production environments these values can be changed.
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        
        switch self {
        case .schools(let limit, let offset):
            urlComponents.path = "/resource/s3k6-pzi2.json"
            urlComponents.queryItems = [
                URLQueryItem(name: "$limit", value: String(limit)),
                URLQueryItem(name: "$offset", value: String(offset)),
                URLQueryItem(name: "$order", value: "school_name"),
            ]
        case .schoolResults(let districtBoroughNumber):
            urlComponents.path = "/resource/f9bf-2cp4.json"
            urlComponents.queryItems = [
                URLQueryItem(name: "dbn", value: districtBoroughNumber),
            ]
        }
        
        guard let url = urlComponents.url else {
            fatalError("Invalid URL.")
        }
        
        return url
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders {
        [
            "Accept": "application/json"
        ]
    }
    
    var timeoutInterval: TimeInterval {
        60.0
    }
}
