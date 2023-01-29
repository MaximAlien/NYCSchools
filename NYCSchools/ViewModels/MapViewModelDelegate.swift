//
//  MapViewModelDelegate.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 28.01.2023.
//

import Foundation

protocol MapViewModelDelegate: AnyObject {
    
    /// Emitted whenever error occurs while `MapViewModel` is performing tasks.
    func didFail(with error: Error)
}
