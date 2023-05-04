//
//  BirdDetailController.swift
//  Project Three
//
//  Created by Marshall Schmutz on 11/16/21.
//

import UIKit
import MapKit

class BirdDetailController: UIViewController {
    @IBOutlet weak var commonName: UILabel!
    @IBOutlet weak var sciName: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var locMap: MKMapView!
    
    var bird: Bird!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonName.text = bird.comName
        sciName.text = bird.sciName
        if let amount = bird.howMany {
            amountLbl.text = "\(amount) birds found in"
        } else {
            amountLbl.text = "No data for bird amount"
        }
        locLbl.text = bird.locName
        setMap(bird: bird)
    }
    
    private func setMap(bird: Bird) {
        let coords = CLLocationCoordinate2D(latitude: bird.lat, longitude: bird.long)
        let region = MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        locMap.setRegion(region, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = coords
        point.title = "Bird spotted"
        locMap.addAnnotation(point)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
