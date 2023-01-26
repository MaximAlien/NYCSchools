//
//  School.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation
import CoreLocation

/// School that contains information about 
struct School: Decodable {
    
    var districtBoroughNumber: String
    
    var name: String
    
    var overview: String
    
    var address: String
    
    var phoneNumber: String
    
    var email: String
    
    var website: URL
    
    var location: CLLocation
    
    enum CodingKeys: String, CodingKey {
        
        case districtBoroughNumber = "dbn"
        case name = "school_name"
        case overview = "overview_paragraph"
        case address = "location"
        case phoneNumber = "phone_number"
        case email = "school_email"
        case website = "website"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        districtBoroughNumber = try container.decode(String.self, forKey: .districtBoroughNumber)
        name = try container.decode(String.self, forKey: .name)
        
        overview = try container.decode(String.self, forKey: .overview)
        address = try container.decode(String.self, forKey: .address)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        email = try container.decode(String.self, forKey: .email)
        website = try container.decode(URL.self, forKey: .website)
        
        let latitude = try container.decode(String.self, forKey: .latitude)
        let longitude = try container.decode(String.self, forKey: .longitude)
        
        location = CLLocation(latitude: CLLocationDegrees(latitude)!, longitude: CLLocationDegrees(longitude)!)
    }
}
