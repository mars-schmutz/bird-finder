//
//  BirdStatisticsViewController.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/17/21.
//

import UIKit

class BirdStatisticsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var birdStore: BirdStore!
    var birdDataSource: BirdDataSource!
    var stats = ["Top Contributors", "Notable Sightings"]
    var containerView = UIView()
    var innerView = UIStackView()
    var statItems = [UILabel]()
    var prevItem: UILabel?
    
    @IBOutlet weak var statPicker: UIPickerView!
    @IBOutlet weak var pickerCard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStatCard()
        topContributors()
        birdStore.fetchRecentBirds(birdURL: BirdsAPI.recentBirdsURL, completion: {
            (birdResult) in
            switch birdResult {
            case let .success(birds):
                self.birdDataSource.birds = birds
            case let .failure(error):
                print("Bird error: \(error)")
            }
        })
    }
    
    func createStatCard() {
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOffset = CGSize(width: 2, height: 4)
        containerView.layer.masksToBounds = false
        containerView.backgroundColor = UIColor(named: "cards")
        let containerViewLayout = view.safeAreaLayoutGuide
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        innerView.axis = .vertical
        innerView.alignment = .fill
        innerView.distribution = .fillEqually
        innerView.spacing = 5
        
        innerView.layer.masksToBounds = true
        innerView.layer.cornerRadius = 12
        innerView.backgroundColor = UIColor(named: "cards")
        innerView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        innerView.isLayoutMarginsRelativeArrangement = true
        let innerViewLayout = containerView.safeAreaLayoutGuide
        innerView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: pickerCard.bottomAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: containerViewLayout.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: containerViewLayout.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: containerViewLayout.bottomAnchor, constant: -10)
        ]
        
        let innerViewConstraints = [
            innerView.leadingAnchor.constraint(equalTo: innerViewLayout.leadingAnchor, constant: 0),
            innerView.bottomAnchor.constraint(equalTo: innerViewLayout.bottomAnchor, constant: 0),
            innerView.trailingAnchor.constraint(equalTo: innerViewLayout.trailingAnchor, constant: 0),
            innerView.topAnchor.constraint(equalTo: innerViewLayout.topAnchor, constant: 0)
        ]
        
        view.addSubview(containerView)
        NSLayoutConstraint.activate(containerViewConstraints)
        
        containerView.addSubview(innerView)
        NSLayoutConstraint.activate(innerViewConstraints)
    }
    
    func addItem(message: String) {
        let item = UILabel()
        item.text = message
        var prevItemLayout: UILayoutGuide?
        var containerLayout = innerView.layoutMarginsGuide
        
        if let prev = prevItem {
            prevItemLayout = prev.layoutMarginsGuide
        } else {
            prevItemLayout = innerView.layoutMarginsGuide
        }
        item.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            item.leadingAnchor.constraint(equalTo: containerLayout.leadingAnchor, constant: 10),
            item.trailingAnchor.constraint(equalTo: containerLayout.trailingAnchor, constant: 10)
        ]
        
        innerView.addArrangedSubview(item)
        if (prevItem != nil) {
            item.topAnchor.constraint(equalTo: prevItemLayout!.bottomAnchor, constant: 10).isActive = true
        } else {
            item.topAnchor.constraint(equalTo: prevItemLayout!.topAnchor, constant: 10).isActive = true
        }
        NSLayoutConstraint.activate(constraints)
        statItems.append(item)
        prevItem = item
    }
    
    func cleanup() {
        for i in statItems {
            innerView.removeArrangedSubview(i)
            i.removeFromSuperview()
        }
        prevItem = nil
        statItems.removeAll()
    }
    
    func topContributors() {
        birdStore.fetchTopContributors {
            (users) in
            switch users {
            case let .success(users):
                for u in 0..<20 {
                    self.addItem(message: "\(u + 1). \(users[u].name), \(users[u].speciesSpotted) species")
                }
            case let .failure(error):
                print("contributors error: \(error)")
            }
        }
    }
    
    func notableSightings() {
        birdStore.fetchRecentBirds(birdURL: BirdsAPI.notableBirdsURL, completion: {
            (birdResponse) in
            switch birdResponse {
            case let .success(birds):
                var amt: Any
                for u in 0..<20 {
                    if (birds[u].howMany != nil) {
                        amt = birds[u].howMany!
                    } else {
                        amt = "n/a"
                    }
                    self.addItem(message: "\(u + 1). \(birds[u].comName), \(amt) amt")
                }
            case let .failure(error):
                print("notable sightings error: \(error)")
            }
        })
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stats.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stats[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (self.stats[row]) {
        case "Top Contributors":
            if (prevItem != nil) {
                cleanup()
            }
            topContributors()
        case "Notable Sightings":
            if (prevItem != nil) {
                cleanup()
            }
            notableSightings()
        case "Clean":
            cleanup()
        default:
            preconditionFailure("Not valid statistic")
        }
    }
}
