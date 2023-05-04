//
//  Users.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/17/21.
//

import Foundation

class User: Codable {
    let name: String
    let speciesSpotted: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "userDisplayName"
        case speciesSpotted = "numSpecies"
    }
}
