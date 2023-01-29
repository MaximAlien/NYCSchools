//
//  UIAlertController.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 28.01.2023.
//

import UIKit

extension UIViewController {
    
    /// Presents an alert view controller with provided title and message.
    /// - Parameters:
    ///   - title: Title of the alert.
    ///   - message: Descriptive text that provides additional details about the reason for the alert.
    func presentAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK".localized,
                                   style: .default)
        
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
