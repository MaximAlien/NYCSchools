//
//  CacheTests.swift
//  NYCSchoolsTests
//
//  Created by Maxim Makhun on 27.01.2023.
//

import Foundation
import XCTest
@testable import NYCSchools

class ObjectMock {
    
    var testProperty = "test_property"
}

class CacheTests: XCTestCase {
    
    override func setUpWithError() throws {
        // No-op
    }
    
    override func tearDownWithError() throws {
        // No-op
    }
    
    func testCache() {
        let expectedObjectMock = ObjectMock()
        let key = "key"
        Cache.shared.setObject(expectedObjectMock, for: key)
        
        var actualObjectMock = Cache.shared.object(for: key) as? ObjectMock
        XCTAssertEqual(actualObjectMock?.testProperty, expectedObjectMock.testProperty)
        
        Cache.shared.removeAllObjects()
        actualObjectMock = Cache.shared.object(for: key) as? ObjectMock
        XCTAssertNil(actualObjectMock)
        
        Cache.shared.setObject(expectedObjectMock, for: key)
        actualObjectMock = Cache.shared.object(for: key) as? ObjectMock
        XCTAssertEqual(actualObjectMock?.testProperty, expectedObjectMock.testProperty)
        
        Cache.shared.removeObject(for: key)
        actualObjectMock = Cache.shared.object(for: key) as? ObjectMock
        XCTAssertNil(actualObjectMock)
    }
}
