//
//  UIImageView.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import MapKit
import CoreLocation
import OSLog

private var AssociatedObjectHandle: UInt8 = 0

extension UIImageView {
    
    /// Convenience property that allows to store own version of the `MKMapSnapshotter`.
    private var mapSnapshotter: MKMapSnapshotter? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedObjectHandle) as? MKMapSnapshotter
        }
        
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedObjectHandle,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Returns MapKit's `MapView` region snapshot based on provided coordinate of the `School`.
    /// - Parameters:
    ///   - school: `School` object that contains coordinate that serves as a center of the region.
    ///   - regionRadius: Radius of the region around coordinate. Defaults to `1500.0` meters.
    ///   - cache: Cache that conforms to `Caching` protocol and allows to cache region's snapshot.
    ///   Defaults to cache that is based on `NSCache`.
    ///   - completion: Completion handler that is called whenever snapshot is taken or error is received.
    func snapshotMap(for school: School,
                     regionRadius: CLLocationDistance = 1500.0,
                     cache: Caching = Cache.shared,
                     completion: ((Result<UIImage, Error>) -> Void)? = nil) {
        // In case if there is already a map snapshotter that attempts to download an image - cancel it.
        mapSnapshotter?.cancel()
        
        // If snapshot of the map is already in cache - return it in the completion handler and set it
        // to be used in image view itself.
        if let cachedImage = cache.object(for: school.districtBoroughNumber) as? UIImage {
            os_log("Cached map snapshot was found for key: %@",
                   log: OSLog.network,
                   type: .debug,
                   school.districtBoroughNumber)
            
            contentMode = .scaleAspectFit
            image = cachedImage
            completion?(.success(cachedImage))
            return
        }
        
        // By default set placeholder image. In case if there are issues with taking a snapshot of the map
        // this default image will be retained.
        contentMode = .center
        tintColor = .white
        image = UIImage(systemName: "map.fill")
        
        guard let coordinate = school.location?.coordinate else {
            completion?(.failure(.noData))
            return
        }
        
        let mapSnapshotterOptions = MKMapSnapshotter.Options()
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        
        mapSnapshotterOptions.region = coordinateRegion
        
        mapSnapshotter = MKMapSnapshotter(options: mapSnapshotterOptions)
        mapSnapshotter?.start(completionHandler: { [weak self] snapshot, error in
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
            
            // Create annotation pin view in the center of the region.
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
            
            self.contentMode = .scaleAspectFit
            self.image = imageWithPin
            cache.setObject(imageWithPin, for: school.districtBoroughNumber)
            completion?(.success(imageWithPin))
        })
    }
}
