//
//  ViewController.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/8/21.
//

import UIKit

class GameStatisticsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var store: GameStore!
    var birdStore: BirdStore!
    var dataSource: GameDataSource!
    var birdDataSource: BirdDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print(">> Steam recently played url: \(SteamAPI.ownedGamesURL)")
        
//        store.fetchOwnedGames {
//            (gameResult) in
//
//            switch gameResult {
//            case let .success(games):
//                print("Successfully found \(games.count) games")
//                self.dataSource.games = games
//                if let firstGame = self.store.ownedGames.first {
//                    self.updateImageView(for: firstGame)
//                }
//            case let .failure(error):
//                print("Error fetching owned games: \(error)")
//                self.dataSource.games.removeAll()
//            }
//            
//        }
//        birdStore.fetchRecentBirds {
//            (birdResult) in
//            switch birdResult {
//            case let .success(birds):
//                self.birdDataSource.birds = birds
//                print("bird response is \(birds.count) items long")
//                print("bird fetch request")
//            case let .failure(error):
//                print("bird error is: \(error)")
//            }
//        }
    }
    
    func cycleBirds(birdsList: [Bird]) {
        for b in birdsList {
            print("Common Name: \(b.comName)")
            print("Scientific Name: \(b.sciName)")
            print("Location: \(b.locName)")
            print("Amount: \(b.howMany ?? -1)")
        }
    }
    
    func updateImageView(for game: Game) {
        store.fetchGameImage(for: game) {
            (imageResult) in
            
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
}

