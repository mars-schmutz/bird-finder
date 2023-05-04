//
//  BirdPreferences.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/17/21.
//

import UIKit

class BirdPreferencesViewController: UIViewController {
    var birdStore: BirdStore!
    var dataSource: BirdDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birdStore.fetchRecentBirds(birdURL: BirdsAPI.recentBirdsURL, completion: {
            (birdResult) in
            switch birdResult {
            case let .success(birds):
                self.dataSource.birds = birds
            case let .failure(error):
                print("Bird error: \(error)")
            }
        })
    }
}
