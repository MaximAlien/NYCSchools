//
//  OSLog.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation
import os

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let network = OSLog(subsystem: subsystem,
                               category: "Network")
}
