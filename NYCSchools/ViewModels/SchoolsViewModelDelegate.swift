//
//  SchoolsViewModelDelegate.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 27.01.2023.
//

import UIKit

protocol SchoolsViewModelDelegate: AnyObject {
    
    /// Emitted whenever error occurs while `SchoolsViewModel` is performing tasks.
    func didFail(with error: Error)
    
    /// Emitted whenever user selects certain `School` in a table view.
    func didSelect(school: School)
    
    /// Emitted whenever `SchoolsViewModel` updates a list of schools.
    func didUpdate(schools: [School])
}
