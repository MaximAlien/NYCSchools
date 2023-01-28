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
    
    // MARK: - Setting-up methods
    
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
        
        tableView.register(UINib(nibName: SchoolTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: SchoolTableViewCell.reuseIdentifier)
        
        tableView.refreshControl = UIRefreshControl()
    }
}

// MARK: - SchoolsViewModelDelegate methods

extension SchoolsViewController: SchoolsViewModelDelegate {
    
    func didFail(with error: Error) {
        let alertController = UIAlertController(title: "NYCSchools".localized,
                                                message: "Error occured: \(error.localizedDescription)",
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK".localized,
                                   style: .default)
        
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    func didSelect(school: School) {
        let viewControllers = tabBarController?.viewControllers
        guard let viewControllers = viewControllers,
              viewControllers.count == 2,
              let mapViewController = viewControllers[1] as? MapViewController else {
                  return
              }
        
        tabBarController?.selectedIndex = 1
        mapViewController.mapViewModel.present(school: school)
    }
    
    func didUpdate(schools: [School]) {
        let viewControllers = tabBarController?.viewControllers
        guard let viewControllers = viewControllers,
              viewControllers.count == 2,
              let mapViewController = viewControllers[1] as? MapViewController,
              mapViewController.mapViewModel != nil else {
                  return
              }
        
        mapViewController.mapViewModel.update(schools: schools)
    }
}
