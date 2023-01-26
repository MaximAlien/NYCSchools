//
//  NYCOpenDataSchoolsEndpoint.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation

enum SchoolsEndpoint {
    
    case search(_ location: CLLocation, category: String, limit: UInt, offset: UInt)
}

extension YelpEndpoint: Endpoint {
    
    static let apiToken = "zhHvtJIpforCJwo8WQFcvF3W4bqYGJJXvLu35R6y8s-qL8Ck8jJpzyRAdlqxQ3mdl1RC9C2M6xhbRCRQ7COso0dTcZnsSwugEdMnMhHyLsuayjQSi2-mPZCqTlDCY3Yx"
    
    var url: URL {
        switch self {
        case .search(let location, let category, let limit, let offset):
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.yelp.com"
            urlComponents.path = "/v3/businesses/search"
            urlComponents.queryItems = [
                URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
                URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
                URLQueryItem(name: "categories", value: category),
                URLQueryItem(name: "sort_by", value: "best_match"), // best_match, rating, review_count or distance
                URLQueryItem(name: "locale", value: "en_US"),
                URLQueryItem(name: "radius", value: String(39_999)), // meters
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
            
            guard let url = urlComponents.url else {
                fatalError("Invalid URL.")
            }
            
            return url
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders {
        [
            "Accept": "application/json",
            "Authorization": "Bearer \(YelpEndpoint.apiToken)"
        ]
    }
    
    var timeoutInterval: TimeInterval {
        60.0
    }
}
