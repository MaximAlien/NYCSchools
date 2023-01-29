//
//  MapViewController.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    var mapViewModel: MapViewModel!
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        
        mapViewModel = MapViewModel(mapView: mapView)
        mapViewModel.delegate = self
    }
    
    // MARK: - Setting-up methods
    
    func setupMapView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        let mapViewConstraints = [
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(mapViewConstraints)
    }
}

// MARK: - MapViewController methods

extension MapViewController: MapViewModelDelegate {
    
    func didFail(with error: Error) {
        presentAlert(with: "NYCSchools".localized,
                     message: "Error occured: \(error.localizedDescription)")
    }
}
