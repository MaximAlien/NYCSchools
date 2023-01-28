//
//  NYCOpenDataService.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation

struct OpenDataService: Service {
    
    var dispatchable: Dispatchable
    
    init(_ dispatcher: Dispatchable = Dispatcher.shared) {
        self.dispatchable = dispatcher
    }
    
    func schools(_ limit: UInt,
                 offset: UInt,
                 completion: @escaping (Result<[School], Error>) -> Void) {
        let endpoint = OpenDataEndpoint.schools(limit, offset: offset)
        
        return dispatchable.execute(endpoint,
                                    completion: completion)
    }
    
    func schoolResults(_ districtBoroughNumber: String,
                       completion: @escaping (Result<[SchoolResults], Error>) -> Void) {
        let endpoint = OpenDataEndpoint.schoolResults(districtBoroughNumber)
        
        return dispatchable.execute(endpoint,
                                    completion: completion)
    }
}
