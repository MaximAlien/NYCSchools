//
//  UIImageView.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import MapKit
import CoreLocation
import OSLog

extension UIImageView {
    
    /// Returns MapKit's `MapView` region snapshot based on provided coordinate.
    /// - Parameters:
    ///   - coordinate: Coordinate that serves as a center of the region.
    ///   - cache: Cache that conforms to `Caching` protocol and allows to cache region's snapshot.
    ///   - completion: Completion handler that is called whenever snapshot is taken or error is received.
    func snapshot(for coordinate: CLLocationCoordinate2D,
                  cache: Caching = Cache.shared,
                  completion: ((Result<UIImage, Error>) -> Void)? = nil) {
        let key = String("\(coordinate.latitude) \(coordinate.longitude)")
        if let cachedImage = cache.object(for: key) as? UIImage {
            image = cachedImage
            return
        }
        
        let mapSnapshotterOptions = MKMapSnapshotter.Options()
        mapSnapshotterOptions.showsBuildings = true
        
        let regionRadius: CLLocationDistance = 1500 // meters
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        
        mapSnapshotterOptions.region = coordinateRegion
        
        let snapshotter = MKMapSnapshotter(options: mapSnapshotterOptions)
        snapshotter.start(completionHandler: { [weak self] snapshot, error in
            guard let self = self else {
                completion?(.failure(.generic(nil)))
                return
            }
            
            if let error = error {
                os_log("Failed to snapshot a map with error: %@",
                       log: OSLog.network,
                       type: .error,
                       error.localizedDescription)
                
                completion?(.failure(.generic(error)))
                return
            }
            
            guard let snapshot = snapshot else {
                os_log("Unable to take a snapshot of the map",
                       log: OSLog.network,
                       type: .error)
                
                completion?(.failure(.generic(nil)))
                return
            }
            
            let imageWithPin = UIGraphicsImageRenderer(size: mapSnapshotterOptions.size).image { _ in
                snapshot.image.draw(at: .zero)
                
                let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
                
                var point = snapshot.point(for: coordinate)
                point.x -= pinView.bounds.width / 2.0
                point.y -= pinView.bounds.height / 2.0
                point.x += pinView.centerOffset.x
                point.y += pinView.centerOffset.y
                pinView.image?.draw(at: point)
            }
            
            self.image = imageWithPin
            cache.setObject(imageWithPin, for: key)
            completion?(.success(imageWithPin))
        })
    }
}
