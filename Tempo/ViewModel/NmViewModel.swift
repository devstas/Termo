//
//  NarodmonViewModel.swift
//  Tempo
//
//  Created by Serov Stas on 23/11/2018.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation

class NmViewModel {
    
    var narodmonApi = NarodMonAPI()
    
    var nmCellViewModelArray = [NmCellViewModel]()
    var nmMapViewModel: MapViewModel!
    
    func getDataSensor(completion: @escaping () -> Void) {
        narodmonApi.sensorsNearby(location: LocationManager.shered.getCoordinateDoubl()) { [weak self] (sensorsNear) in
            self?.nmCellViewModelArray = sensorsNear.devices.map{ NmCellViewModel(device: $0) }
            completion()
        }
    }
    
    func getNmCellViewModel(index: Int) -> NmCellViewModel {
        return nmCellViewModelArray[index]
    }
    
    func getNmCountOfCell() -> Int {
        return nmCellViewModelArray.count
    }
    
    func getMapViewModel() -> MapViewModel {
        return nmMapViewModel
    }
    
}
