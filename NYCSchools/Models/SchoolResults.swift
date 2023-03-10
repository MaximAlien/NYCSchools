//
//  SchoolResults.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import Foundation

/// Contains information about the SAT (Scholastic Assessment Test) scores in NYC schools.
struct SchoolResults: Decodable {
    
    /// Combination of the district number, the letter code for the borough,
    /// and the number of the school.
    var districtBoroughNumber: String
    
    /// Name of the school.
    var name: String?
    
    /// Number of the SAT test takers.
    var numberOfTestTakers: UInt64?
    
    /// SAT critical reading average score.
    var criticalReadingAverageScore: UInt64?
    
    /// SAT mathematics average score.
    var mathematicsAverageScore: UInt64?
    
    /// SAT mathematics average score.
    var writingAverageScore: UInt64?
    
    enum CodingKeys: String, CodingKey {
        
        case districtBoroughNumber = "dbn"
        case name = "school_name"
        case numberOfTestTakers = "num_of_sat_test_takers"
        case criticalReeadingAverageScore = "sat_critical_reading_avg_score"
        case mathematicsAverageScore = "sat_math_avg_score"
        case writingAverageScore = "sat_writing_avg_score"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        districtBoroughNumber = try container.decode(String.self, forKey: .districtBoroughNumber)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        
        if let numberOfTestTakersAsString = try container.decodeIfPresent(String.self, forKey: .numberOfTestTakers) {
            numberOfTestTakers = UInt64(numberOfTestTakersAsString) ?? 0
        }
        
        if let criticalReadingAverageScoreAsString = try container.decodeIfPresent(String.self, forKey: .criticalReeadingAverageScore) {
            criticalReadingAverageScore = UInt64(criticalReadingAverageScoreAsString) ?? 0
        }
        
        if let mathematicsAverageScoreAsString = try container.decodeIfPresent(String.self, forKey: .mathematicsAverageScore) {
            mathematicsAverageScore = UInt64(mathematicsAverageScoreAsString) ?? 0
        }
        
        if let writingAverageScoreAsString = try container.decodeIfPresent(String.self, forKey: .writingAverageScore) {
            writingAverageScore = UInt64(writingAverageScoreAsString) ?? 0
        }
    }
}

// MARK: - SchoolResults extension

extension SchoolResults {
    
    /// Provides string with SAT (Scholastic Assessment Test) scores that is used in `MKPointAnnotation`.
    var annotationSubtitle: String? {
        guard let criticalReadingAverageScore = criticalReadingAverageScore,
              let writingAverageScore = writingAverageScore,
              let mathematicsAverageScore = mathematicsAverageScore else {
                  return nil
              }
        
        // Given more time I would implement flexible functionality that allows to localize such strings.
        return "Reading: \(criticalReadingAverageScore), Writing: \(writingAverageScore), Math: \(mathematicsAverageScore)"
    }
}
