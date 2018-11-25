//
//  XuViewModel.swift
//  Tempo
//
//  Created by Serov Stas on 22/11/2018.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation


class XuViewModel {
    
    var xu = XuAPI()
    
    // viewModel
    private var xuCellViewModelArray = [XuCellViewModel]()
    private var xuCurrentTempViewModel: XuCurrent!
    
    func updateWeather(completion: @escaping (XuHeaderViewModel) -> Void ) {
        
        guard let coordinate = LocationManager.shered.getCoordinateString() else {return}
        xu.location = coordinate
        
        xu.getWeather { (xuWeather) in

            if let forecastday = xuWeather.forecast?.forecastday {
                self.xuCellViewModelArray = forecastday.map { XuCellViewModel($0) }
            }
            
            let xuHeaderViewModel = XuHeaderViewModel(xuCurrent: xuWeather.current!)
            xuHeaderViewModel.city = xuWeather.location?.name
            completion(xuHeaderViewModel)
        }
    }
    
    func getXuCountOfCell() -> Int {
        return xuCellViewModelArray.count
    }
    
    func getXuCellViewModel(index: Int) -> XuCellViewModel {
        return xuCellViewModelArray[index]
    }
    
}








