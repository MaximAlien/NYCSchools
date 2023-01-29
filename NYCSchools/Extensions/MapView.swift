//
//  MapView.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 28.01.2023.
//

import MapKit

extension MKMapView {
    
    /// Removes all annotations that are currently present on a map.
    func removeAllAnnotations() {
        removeAnnotations(annotations)
    }
    
    /// Zooms-in to specified coordinate.
    /// - Parameters:
    ///   - coordinate: The center of the coordinate region.
    ///   - regionRadius: Radius of the region. Defaults to `1500.0` meters.
    ///   - animated: Controls whether transition to the new region in animated.
    func zoomIn(to coordinate: CLLocationCoordinate2D,
                regionRadius: CLLocationDistance = 1500.0,
                animated: Bool = true) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
