//
//  TabBarController.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    let schoolsViewController = SchoolsViewController()
    let mapViewController = MapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [
            schoolsViewController,
            mapViewController
        ]
        
        setViewControllers(viewControllers, animated: false)
        delegate = self
        
        setupTabBarItems()
    }
    
    func setupTabBarItems() {
        guard let tabBarItems = tabBar.items else {
            return
        }
        
        tabBarItems.enumerated().forEach {
            switch $0.offset {
            case 0:
                $0.element.title = "List".localized
                $0.element.image = UIImage(systemName: "list.bullet")
            case 1:
                $0.element.title = "Map".localized
                $0.element.image = UIImage(systemName: "map")
            default:
                assertionFailure("Invalid UITabBarItem index.")
            }
        }
    }
}

// MARK: - UITabBarControllerDelegate methods

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard tabBarController.viewControllers?.count == 2,
              let mapViewController = viewController as? MapViewController,
              let schoolsViewController = tabBarController.viewControllers?[0] as? SchoolsViewController else {
                  return
              }
        
        mapViewController.mapViewModel.update(schools: schoolsViewController.schoolsViewModel.schools)
    }
}
