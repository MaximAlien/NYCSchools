//
//  UIAlertController.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 28.01.2023.
//

import UIKit

extension UIViewController {
    
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
