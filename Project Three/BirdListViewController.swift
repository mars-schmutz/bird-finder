//
//  BirdListViewController.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/16/21.
//

import UIKit

class BirdListViewController: UITableViewController {
    var dataSource: BirdDataSource!
    var birdStore: BirdStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.rowHeight = 100
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "birdDetails":
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = dataSource.birds[row]
                let dest = segue.destination as! BirdDetailController
                dest.bird = item
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
}
