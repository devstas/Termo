//
//  TableView.swift
//  Tempo
//
//  Created by Serov Stas on 26.10.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit

class XuTableView: UITableView {
    
    @IBOutlet weak var labelCurrentTemp: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var labelFeelTemp: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    
    @IBOutlet weak var labHumidity: UILabel!
    @IBOutlet weak var labPressure: UILabel!
    @IBOutlet weak var labWindSpeed: UILabel!
    @IBOutlet weak var labVisibility: UILabel!
    
    weak var viewModel: XuHeaderViewModel! {
        didSet{
            self.labelCurrentTemp.text = viewModel.currentTemp
            self.labelInfo.text = viewModel.conditionInfoTemp
            self.labelFeelTemp.text = viewModel.feelTemp
            
            self.labHumidity.text = viewModel.humidity
            self.labPressure.text = viewModel.pressure
            self.labWindSpeed.text = viewModel.windSpeed
            self.labVisibility.text = viewModel.visibility
            
            Network.shared.downloadImage(url: viewModel.urlImageWeather) { (image) in
                self.imageWeather.image = image
            }
        }
    }
    
    // TableView - paralax effect
    @IBOutlet weak var heigth: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else {return}
        let offsetY = -contentOffset.y
        bottom.constant = offsetY >= 0 ? 0 : offsetY / 2
        heigth.constant = max(header.bounds.height, header.bounds.height + offsetY)
        header.clipsToBounds = offsetY <= 0
    }
}


