//
//  BirdDataSource.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/16/21.
//

import UIKit

class BirdDataSource: NSObject, UITableViewDataSource {
    var birds = [Bird]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! BirdTableViewCell
        let item = birds[indexPath.row]
        cell.commonNameLbl.text = item.comName
        cell.locLbl.text = item.locName
        cell.date.text = item.obsDt
        return cell
    }
}
