//
//  SchoolsViewController.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import UIKit

class SchoolsViewController: UIViewController {
    
    var tableView: UITableView!
    
    var schoolsViewModel: SchoolsViewModel!
    
    // MARK: - UIViewController lifecycle methods
    
    open override func loadView() {
        // Custom view is used to provide the ability to set custom style.
        let frame = parent?.view.bounds ?? UIScreen.main.bounds
        view = BackgroundView(frame: frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        schoolsViewModel = SchoolsViewModel(tableView)
        schoolsViewModel.delegate = self
        schoolsViewModel.loadSchools()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.userInterfaceStyle == traitCollection.userInterfaceStyle { return }
        
        schoolsViewModel.updateStyle(for: traitCollection)
    }
    
    // MARK: - Setting-up methods
    
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}

// MARK: - SchoolsViewModelDelegate methods

extension SchoolsViewController: SchoolsViewModelDelegate {
    
    func didFail(with error: Error) {
        presentAlert(with: "NYCSchools".localized,
                     message: "Error occured: \(error.localizedDescription)")
    }
    
    func didSelect(school: School) {
        guard let mapViewController = tabBarController?.viewControllers?.compactMap({ $0 as? MapViewController }).first else {
            return
        }
        
        tabBarController?.selectedIndex = 1
        mapViewController.mapViewModel.present(school: school)
    }
    
    func didUpdate(schools: [School]) {
        guard let mapViewController = tabBarController?.viewControllers?.compactMap({ $0 as? MapViewController }).first,
              mapViewController.mapViewModel != nil else {
                  return
              }
        
        mapViewController.mapViewModel.update(schools: schools)
    }
}
