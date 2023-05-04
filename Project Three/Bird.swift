//
//  Bird.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/15/21.
//

import Foundation

class Bird: Codable, Equatable {
    let id = UUID()
    let comName: String
    let sciName: String
    let locName: String
    let obsDt: String
    let howMany: Int?
    let lat: Double
    let long: Double
    
    enum CodingKeys: String, CodingKey {
        case comName = "comName"
        case sciName = "sciName"
        case locName = "locName"
        case obsDt = "obsDt"
        case howMany = "howMany"
        case lat = "lat"
        case long = "lng"
    }
    
    static func ==(lhs: Bird, rhs: Bird) -> Bool {
        return lhs.id == rhs.id
    }
}
