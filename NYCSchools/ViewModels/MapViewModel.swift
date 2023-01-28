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
    
    let openDataService = OpenDataService()
    
    init(mapView: MKMapView) {
        super.init()
        
        self.mapView = mapView
        self.mapView?.delegate = self
    }
    
    func present(school: School) {
        removeAllAnnotations()
        
        if let schoolAnnotation = school.annotation {
            zoomInMapView(to: schoolAnnotation.coordinate)
            mapView?.addAnnotation(schoolAnnotation)
            
            openDataService.schoolResults(school.districtBoroughNumber) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let schoolResults):
                    if let schoolResult = schoolResults.first,
                       let criticalReadingAverageScore = schoolResult.criticalReadingAverageScore,
                       let writingAverageScore = schoolResult.writingAverageScore,
                       let mathematicsAverageScore = schoolResult.mathematicsAverageScore {
                        let subtitle = "Reading: \(criticalReadingAverageScore), Writing: \(writingAverageScore), Math: \(mathematicsAverageScore)"
                        schoolAnnotation.subtitle = subtitle
                        self.mapView?.selectAnnotation(schoolAnnotation, animated: true)
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func update(schools: [School]) {
        removeAllAnnotations()
        mapView?.showAnnotations(schools.compactMap({ $0.annotation }),
                                 animated: true)
    }
    
    func zoomInMapView(to coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1500 // meters
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView?.setRegion(coordinateRegion, animated: true)
    }
    
    func removeAllAnnotations() {
        guard let annotations = mapView?.annotations else {
            return
        }
        
        mapView?.removeAnnotations(annotations)
    }
}

// MARK: - MKMapViewDelegate methods

extension MapViewModel: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if let annotationView = annotationView {
            annotationView.annotation = annotation
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        return annotationView
    }
}
