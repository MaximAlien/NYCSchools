//
//  MapViewTests.swift
//  NYCSchoolsTests
//
//  Created by Maxim Makhun on 28.01.2023.
//

import XCTest
import MapKit
@testable import NYCSchools

class MapViewTests: XCTestCase {
    
    override func setUpWithError() throws {
        // No-op
    }
    
    override func tearDownWithError() throws {
        // No-op
    }
    
    func testMapViewAnnotationAdditionAndRemoval() {
        let mapView = MKMapView()
        
        let annotations: [MKAnnotation] = [
            MKPointAnnotation(),
            MKPointAnnotation()
        ]
        
        mapView.addAnnotations(annotations)
        XCTAssertEqual(mapView.annotations.count, 2)
        
        mapView.removeAllAnnotations()
        XCTAssertEqual(mapView.annotations.count, 0)
    }
}
