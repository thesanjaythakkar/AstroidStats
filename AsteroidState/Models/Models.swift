//
//  Models.swift
//  AsteroidState
//
//  Created by Sanjay Thakkar on 07/02/23.
//

import Foundation

// MARK: - AstroidsResponse
struct AstroidsResponse: Codable {
    let elementCount: Int
    let nearEarthObjects: [String:[NearEarthObject]]

    enum CodingKeys: String, CodingKey {
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

// MARK: - NearEarthObject
struct NearEarthObject: Codable {
    let id, name: String
    let nasaJplURL: String
    let estimatedDiameter: EstimatedDiameter
    let closeApproachData: [CloseApproachDatum]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nasaJplURL = "nasa_jpl_url"
        case estimatedDiameter = "estimated_diameter"
        case closeApproachData = "close_approach_data"
    }
    
    func speed()->Double {
        return Double(closeApproachData.first!.relativeVelocity.kilometersPerSecond)!
    }
    func distance()->String {
        return closeApproachData.first!.missDistance.kilometers
    }
    func closeDate() -> Date {
        return closeApproachData.first!.closeApproachDateFull.toValidFormat()
    }
    func avgDiameter() -> Double {
        Double((Double(estimatedDiameter.kilometers.min) + Double(estimatedDiameter.kilometers.max))/2)
    }
}
// MARK: - MissDistance
struct MissDistance: Codable {
    let kilometers: String
}
// MARK: - CloseApproachDatum
struct CloseApproachDatum: Codable {
    let closeApproachDateFull: String
    let relativeVelocity: RelativeVelocity
    let missDistance:MissDistance
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDateFull = "close_approach_date_full"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
    }
}

// MARK: - RelativeVelocity
struct RelativeVelocity: Codable {
    let kilometersPerSecond: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
    }
}

// MARK: - EstimatedDiameter
struct EstimatedDiameter: Codable {
    let kilometers: Diameter
}

// MARK: - Diameter
struct Diameter: Codable {
    let min, max: Double

    enum CodingKeys: String, CodingKey {
        case min = "estimated_diameter_min"
        case max = "estimated_diameter_max"
    }
}

enum eTypeOfAstroid {
    case fastest(date:String, speed:String, id:String)
    case closes(date:String, distance:String, id:String)
    case average(diameter:String)
    
    var title:String {
        switch self {
        case .fastest(_, _, _):
            return "Fastest"
        case .closes(_, _, _):
            return "Closest"
        case .average(_):
            return "Average"
        }
    }
}

struct AstroidObject {
    var date:String?
    var astroids:[NearEarthObject]?
    
    func fastestAmong() -> NearEarthObject {
        return astroids!.sorted(by: { obj1, obj2 in
            return obj1.speed() > obj2.speed()
        }).first!
    }
    
    func closesAmoug() -> NearEarthObject {
        return astroids!.sorted(by: { obj1, obj2 in
            return obj1.closeDate() > obj2.closeDate()
        }).first!
    }
}

