//
//  SteamAPI.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/11/21.
//

import Foundation

enum Birds: String {
    case recentBirds = "https://api.ebird.org/v2/data/obs/US-UT/recent"
    case topContributors = "https://api.ebird.org/v2/product/top100/US-UT/"
    case regionStats = "https://api.ebird.org/v2/product/stats/US-UT/"
}

struct BirdsAPI {
//    private static let baseURL = "http://api.steampowered.com/"
    private static let apiKey = "A5DADC4CE3E77DB028D7DE986DD5F0B0"
    private static let birdsKey = "3d6ke0sqp45c"
    
    static var recentBirdsURL: URL {
        return birdsURL(endpoint: .recentBirds, endData: nil, params: nil)
    }
    
    static var notableBirdsURL: URL {
        return birdsURL(endpoint: .recentBirds, endData: "/notable", params: nil)
    }
    
    static var topContributorsURL: URL {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let calenderDate = Calendar.current.dateComponents([.day, .year, .month], from: yesterday!)
        let y = calenderDate.year
        let m = calenderDate.month
        let d = calenderDate.day
        return birdsURL(endpoint: .topContributors, endData: "\(y!)" + "/\(m!)" + "/\(d!)", params: nil)
    }
    
    static var regionStats: URL {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let calenderDate = Calendar.current.dateComponents([.day, .year, .month], from: yesterday!)
        let y = calenderDate.year
        let m = calenderDate.month
        let d = calenderDate.day
        return birdsURL(endpoint: .regionStats, endData: "\(y!)" + "/\(m!)" + "/\(d!)", params: nil)
    }
    
    static func birdsURL(endpoint: Birds, endData: String?, params: [String: String]?) -> URL {
        var components: URLComponents
        if let end = endData {
            components = URLComponents(string: endpoint.rawValue + end)!
        } else {
            components = URLComponents(string: endpoint.rawValue)!
        }
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "key": birdsKey,
            "maxResults": "50"
        ]
        
        for (k, v) in baseParams {
            let item = URLQueryItem(name: k, value: v)
            queryItems.append(item)
        }
        
        if let additionalParams = params {
            for (k, v) in additionalParams {
                let item = URLQueryItem(name: k, value: v)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    static func birds(fromJSON data: Data) -> Result<[Bird], Error> {
        do {
            let decoder = JSONDecoder()
            let birdResponse = try decoder.decode([Bird].self, from: data)
            return .success(birdResponse)
        } catch {
            return .failure(error)
        }
    }
    
    static func users(fromJSON data: Data) -> Result<[User], Error> {
        do {
            let decoder = JSONDecoder()
            let resp = try decoder.decode([User].self, from: data)
            return .success(resp)
        } catch {
            return .failure(error)
        }
    }
}
