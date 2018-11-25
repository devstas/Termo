//
    //  StaticViewController.swift
//  Tempo
//
//  Created by Devolper on 15.05.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let ann = [MKAnnotation]()
        
        var annotation = [MKPointAnnotation]()
        
        guard NarodMonAPI.dataSensorsNearby?.devices != nil else {return}
        
        for device in (NarodMonAPI.dataSensorsNearby?.devices)! {
            let annot = MKPointAnnotation()
            annot.title = device.name
            
                var subTitel = ""
            for sens in device.sensors {
                    if sens.type == 1 {
                        annot.title = "\(String(sens.value!)) \(String(sens.unit!))\n[\(String(sens.name!))]\n"
                    } else {
                        subTitel += "\(String(sens.name!)) = \(String(sens.value!)) \(String(sens.unit!))\n"
                    }
                }
                annot.subtitle = subTitel
            let coord2d = CLLocationCoordinate2D(latitude: (device.lat)!, longitude: (device.lng)!)
            annot.coordinate = coord2d
            annotation.append(annot)
        }

        print("View on the map - \(annotation.count)")
        mapView.addAnnotations(annotation)
        mapView.showAnnotations(annotation, animated: true)
        
        //mapView.selectedAnnotations = annotation
        //mapView.selectAnnotation(annotation[0], animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {

}

