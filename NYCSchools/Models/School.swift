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
    
    /// Combination of the district number, the letter code for the borough,
    /// and the number of the school.
    var districtBoroughNumber: String
    
    /// Name of the school.
    var name: String?
    
    /// Overview of the school.
    var overview: String?
    
    /// Address of the school (including street, borough, zip code and location).
    var address: String?
    
    /// Phone number of the school.
    var phoneNumber: String?
    
    /// Email of the school.
    var email: String?
    
    /// Website of the school.
    var website: URL?
    
    /// Location of the school.
    var location: CLLocation?
    
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
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        website = try container.decodeIfPresent(URL.self, forKey: .website)
        
        if let latitude = try container.decodeIfPresent(String.self, forKey: .latitude),
           let longitude = try container.decodeIfPresent(String.self, forKey: .longitude),
           let latitude = CLLocationDegrees(latitude),
           let longitude = CLLocationDegrees(longitude) {
            location = CLLocation(latitude: latitude, longitude: longitude)
        }
    }
}
