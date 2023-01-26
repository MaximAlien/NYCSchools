//
//  DecoderTests.swift
//  NYCSchoolsTests
//
//  Created by Maxim Makhun on 24.01.2023.
//

import XCTest
import CoreLocation
@testable import NYCSchools

class DecoderTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testSchoolsDecoding() {
        guard let schools = decode("Schools", decodableType: [School].self)else {
            XCTFail("Failed to decode the data.")
            return
        }
        
        XCTAssertEqual(schools.count, 2)
        XCTAssertEqual(schools[0].districtBoroughNumber, "02M260")
        XCTAssertEqual(schools[0].name, "Clinton School Writers & Artists, M.S. 260")
        XCTAssertEqual(schools[0].overview, "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.")
        XCTAssertEqual(schools[0].address, "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)")
        XCTAssertEqual(schools[0].phoneNumber, "212-524-4360")
        XCTAssertEqual(schools[0].email, "admissions@theclintonschool.net")
        XCTAssertEqual(schools[0].website, URL(string: "www.theclintonschool.net")!)
        
        let expectedLocation = CLLocation(latitude: 40.73653000, longitude: -73.99270000)
        XCTAssertEqual(schools[0].location.coordinate.latitude, expectedLocation.coordinate.latitude)
        XCTAssertEqual(schools[0].location.coordinate.longitude, expectedLocation.coordinate.longitude)
    }
    
    func testSchoolsResultsDecoding() {
        guard let schoolResults = decode("SchoolResults", decodableType: [SchoolResults].self)else {
            XCTFail("Failed to decode the data.")
            return
        }
        
        XCTAssertEqual(schoolResults.count, 2)
        XCTAssertEqual(schoolResults[0].name, "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES")
        XCTAssertEqual(schoolResults[0].numberOfTestTakers, 29)
        XCTAssertEqual(schoolResults[0].criticalReadingAverageScore, 355)
        XCTAssertEqual(schoolResults[0].mathematicsAverageScore, 404)
        XCTAssertEqual(schoolResults[0].writingAverageScore, 363)
    }
    
    func decode<T: Decodable>(_ filename: String, decodableType: T.Type) -> T? {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            XCTFail("Missing file: \(filename).")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Data should be valid.")
            return nil
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(decodableType, from: data)
            return decodedObject
        } catch DecodingError.dataCorrupted(let context) {
            XCTFail("Data corrupted error occured: \(context.debugDescription)")
        } catch DecodingError.keyNotFound(let key, let context) {
            XCTFail("Key not found error occured for key \(key): \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            XCTFail("Type mismatch error occured for type \(type): \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            XCTFail("Value not found error occured for type: \(type): \(context.debugDescription)")
        } catch {
            XCTFail("Unknown error occured: \(error)")
        }
        
        return nil
    }
}
