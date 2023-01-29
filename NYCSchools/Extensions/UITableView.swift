//
//  UITableView.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import UIKit

extension UITableView {
    
    /// Returns a reusable table-view cell object after locating it by its identifier.
    /// - Returns: The index path specifying the location of the cell.
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(T.reuseIdentifier).")
        }
        
        return cell
    }
}
