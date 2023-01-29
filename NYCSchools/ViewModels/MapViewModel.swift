//
//  MapViewModel.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 27.01.2023.
//

import UIKit
import MapKit

final class MapViewModel: NSObject {
    
    weak var mapView: MKMapView? = nil
    
    weak var delegate: MapViewModelDelegate? = nil
    
    init(mapView: MKMapView) {
        super.init()
        
        self.mapView = mapView
        self.mapView?.delegate = self
    }
    
    func present(school: School) {
        guard let schoolAnnotation = school.annotation,
              let mapView = mapView else {
                  return
              }
        
        mapView.removeAllAnnotations()
        mapView.zoomIn(to: schoolAnnotation.coordinate)
        mapView.addAnnotation(schoolAnnotation)
        
        OpenDataService().schoolResults(school.districtBoroughNumber) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let schoolResults):
                schoolAnnotation.subtitle = schoolResults.first?.annotationSubtitle
                mapView.selectAnnotation(schoolAnnotation, animated: true)
            case .failure(let error):
                self.delegate?.didFail(with: error)
            }
        }
    }
    
    func update(schools: [School]) {
        guard let mapView = mapView else {
            return
        }
        
        mapView.removeAllAnnotations()
        mapView.showAnnotations(schools.compactMap({ $0.annotation }),
                                animated: true)
    }
}

// MARK: - MKMapViewDelegate methods

extension MapViewModel: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKPinAnnotationView.reuseIdentifier) as? MKPinAnnotationView
        
        if let annotationView = annotationView {
            annotationView.annotation = annotation
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation,
                                                 reuseIdentifier: MKPinAnnotationView.reuseIdentifier)
            annotationView?.canShowCallout = true
        }
        
        return annotationView
    }
}
