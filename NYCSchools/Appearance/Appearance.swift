//
//  Appearance.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import UIKit

final class Appearance {
    
    /// Applies appearance for light and dark user interface styles.
    static func setup() {
        let lightUserInterfaceStyle = UITraitCollection(userInterfaceStyle: .light)
        let darkUserInterfaceStyle = UITraitCollection(userInterfaceStyle: .dark)
        
        let attributesNormalLightUserInterfaceStyle = [
            NSAttributedString.Key.foregroundColor: UIColor.lightBlue
        ]
        UITabBarItem.appearance(for: lightUserInterfaceStyle).setTitleTextAttributes(attributesNormalLightUserInterfaceStyle,
                                                                                     for: .normal)
        
        let attributesNormalDarkUserInterfaceStyle = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UITabBarItem.appearance(for: darkUserInterfaceStyle).setTitleTextAttributes(attributesNormalDarkUserInterfaceStyle,
                                                                                    for: .normal)
        
        let attributesSelectedLightUserInterfaceStyle = [
            NSAttributedString.Key.foregroundColor: UIColor.lightBlue
        ]
        UITabBarItem.appearance(for: lightUserInterfaceStyle).setTitleTextAttributes(attributesSelectedLightUserInterfaceStyle,
                                                                                     for: .selected)
        
        let attributesSelectedDarkUserInterfaceStyle = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UITabBarItem.appearance(for: darkUserInterfaceStyle).setTitleTextAttributes(attributesSelectedDarkUserInterfaceStyle,
                                                                                    for: .selected)
        
        UITabBar.appearance(for: lightUserInterfaceStyle).backgroundColor = .white
        UITabBar.appearance(for: darkUserInterfaceStyle).backgroundColor = .darkBlue
        
        UITabBar.appearance(for: lightUserInterfaceStyle).barTintColor = .lightBlue
        UITabBar.appearance(for: darkUserInterfaceStyle).barTintColor = .white
        
        UITabBar.appearance(for: lightUserInterfaceStyle).tintColor = .lightBlue
        UITabBar.appearance(for: darkUserInterfaceStyle).tintColor = .white
        
        BackgroundView.appearance(for: lightUserInterfaceStyle).backgroundColor = .white
        BackgroundView.appearance(for: darkUserInterfaceStyle).backgroundColor = .black
        
        let lightUserInterfaceStyleTabBarAppearance = UITabBarAppearance()
        lightUserInterfaceStyleTabBarAppearance.configureWithOpaqueBackground()
        lightUserInterfaceStyleTabBarAppearance.backgroundColor = .white
        UITabBar.appearance(for: lightUserInterfaceStyle).standardAppearance = lightUserInterfaceStyleTabBarAppearance
        UITabBar.appearance(for: lightUserInterfaceStyle).scrollEdgeAppearance = UITabBar.appearance(for: lightUserInterfaceStyle).standardAppearance
        
        let darkUserInterfaceStyleTabBarAppearance = UITabBarAppearance()
        darkUserInterfaceStyleTabBarAppearance.configureWithOpaqueBackground()
        darkUserInterfaceStyleTabBarAppearance.backgroundColor = .darkBlue
        UITabBar.appearance(for: darkUserInterfaceStyle).standardAppearance = darkUserInterfaceStyleTabBarAppearance
        UITabBar.appearance(for: darkUserInterfaceStyle).scrollEdgeAppearance = UITabBar.appearance(for: darkUserInterfaceStyle).standardAppearance
        
        CellBackgroundView.appearance(for: lightUserInterfaceStyle).backgroundColor = .lightBlue
        CellBackgroundView.appearance(for: darkUserInterfaceStyle).backgroundColor = .darkBlue
        
        SchoolNameLabel.appearance(for: lightUserInterfaceStyle).textColor = .white
        SchoolNameLabel.appearance(for: darkUserInterfaceStyle).textColor = .white
        SchoolNameLabel.appearance().font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        SchoolNameLabel.appearance().backgroundColor = .clear
        
        SchoolAddressLabel.appearance(for: lightUserInterfaceStyle).textColor = .white
        SchoolAddressLabel.appearance(for: darkUserInterfaceStyle).textColor = .white
        SchoolAddressLabel.appearance().font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        SchoolAddressLabel.appearance().backgroundColor = .clear
        
        SchoolEmailLabel.appearance(for: lightUserInterfaceStyle).textColor = .white
        SchoolEmailLabel.appearance(for: darkUserInterfaceStyle).textColor = .white
        SchoolEmailLabel.appearance().font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        SchoolEmailLabel.appearance().backgroundColor = .clear
        
        SchoolWebsiteLabel.appearance(for: lightUserInterfaceStyle).textColor = .white
        SchoolWebsiteLabel.appearance(for: darkUserInterfaceStyle).textColor = .white
        SchoolWebsiteLabel.appearance().font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        SchoolWebsiteLabel.appearance().backgroundColor = .clear
        
        UIRefreshControl.appearance(for: lightUserInterfaceStyle).tintColor = .darkGray
        UIRefreshControl.appearance(for: darkUserInterfaceStyle).tintColor = .white
    }
}
