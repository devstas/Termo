//
//  NmMapViewController.swift
//  Tempo
//
//  Created by Serov Stas on 15.05.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit
import MapKit


class NmMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var coordinateView = (55.4507, 37.3656) //Moscow
    
    var viewModel: MapViewModel! {
        didSet {
            if viewModel != nil {
                viewModel.getDataSensor(location: coordinateView) {
                    self.mapReloadData()
                }
            }
        }
    }
    
    @IBOutlet weak var reloadBtn: UIButton!
    
    var timer: Timer!
    var timerCounter = 0
    
    @IBAction func reloadBtn(_ sender: UIButton) {
        if timerCounter <= 0 {
            coordinateView = (self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude)
            viewModel.getDataSensor(location: coordinateView) {
                self.mapReloadData()
            }
            
            timerCounter = 61
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshTimer(_:)), userInfo: nil, repeats: true)
        }
    }

    @objc func refreshTimer(_ :Any) {
        reloadBtn.setImage(nil, for: .normal)
        timerCounter -= 1

        if timerCounter <= 0 {
            timer.invalidate()
            reloadBtn.setImage(UIImage(named: "cycle") , for: .normal)
        } else {
            reloadBtn.setTitle(String(timerCounter), for: .normal)
        }
    }
    
    func mapReloadData() {
        var annotation = [MKPointAnnotation]()
        
        for item in self.viewModel.devices {
            let point = MKPointAnnotation()
            point.coordinate = item.coordinate
            point.title = item.name
            point.subtitle = item.title
            
            annotation.append(point)
        }
        
        mapView.addAnnotations(annotation)
        mapView.showAnnotations(annotation, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadBtn.layer.cornerRadius = 8
        
        if let coordinate = LocationManager.shered.getCoordinateDoubl() {
            coordinateView = coordinate
        }
        viewModel = MapViewModel()
    }
}

