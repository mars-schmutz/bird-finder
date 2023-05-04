//
//  BirdStore.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/15/21.
//

import UIKit

enum StatType {
    case topContrib
}

class BirdStore {
    var allBirds = [Bird]()
    var viewStats: StatType
    
    init() {
        viewStats = .topContrib
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentBirds(birdURL: URL?, completion: @escaping (Result<[Bird], Error>) -> Void) {
        let url: URL
        if let u = birdURL {
            url = u
        } else {
            url = BirdsAPI.recentBirdsURL
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, resp, err) in
            
            let result = self.processBirdsRequest(data: data, error: err)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchTopContributors(completion: @escaping(Result<[User], Error>) -> Void) {
        let url = BirdsAPI.topContributorsURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, resp, err) in
            let result = self.processUserRequest(data: data, error: err)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchNotableBirds(completion: @escaping(Result<[Bird], Error>) -> Void) {
        let url = BirdsAPI.notableBirdsURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, resp, err) in
            let result = self.processBirdsRequest(data: data, error: err)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processBirdsRequest(data: Data?, error: Error?) -> Result<[Bird], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return BirdsAPI.birds(fromJSON: jsonData)
    }
    
    private func processUserRequest(data: Data?, error: Error?) -> Result<[User], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return BirdsAPI.users(fromJSON: jsonData)
    }
}
