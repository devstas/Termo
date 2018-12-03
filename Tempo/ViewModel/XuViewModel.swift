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
    
//    required init(weatherManager: XuAPI) {
//        self.xu = weatherManager
//    }
    
    // viewModels
    private var xuCellViewModelArray = [XuCellViewModel]()
    private var xuHeaderViewModel: XuHeaderViewModel!

    func updateWeather(completion: @escaping (XuHeaderViewModel) -> Void ) {
        
        xu.getWeather(location: LocationManager.shered.getCoordinateString()) { (xuWeather) in
        
        self.xuCellViewModelArray.removeAll()
            if let forecastday = xuWeather.forecast?.forecastday {
                self.xuCellViewModelArray = forecastday.map { XuCellViewModel($0) }
            }
            
            self.xuHeaderViewModel = XuHeaderViewModel(xuCurrent: xuWeather.current!)
            self.xuHeaderViewModel.city = xuWeather.location?.name
            completion(self.xuHeaderViewModel)
        }
    }
    
    func getXuCountOfCell() -> Int {
        return xuCellViewModelArray.count
    }
    
    func getXuCellViewModel(index: Int) -> XuCellViewModel? {
        guard index < xuCellViewModelArray.count else { return nil }
        return xuCellViewModelArray[index]
    }
    
}








