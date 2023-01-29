//
//  String.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import Foundation

extension String {
    
    /// Returns a localized version of a string from the default table (if present),
    /// which Xcode autogenerates when exporting localizations.
    var localized: String {
        NSLocalizedString(self,
                          comment: "")
    }
}
