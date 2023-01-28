//
//  String.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self,
                          comment: "")
    }
}
