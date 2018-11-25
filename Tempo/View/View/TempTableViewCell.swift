//
//  TempTableViewCell.swift
//  Tempo
//
//  Created by Devolper on 25.10.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit


class TempTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var labelTempDay: UILabel!
    @IBOutlet weak var labelTempNigth: UILabel!
    
    weak var viewModel: XuCellViewModel? {
        didSet {
            self.labelDate.text = (viewModel?.date)!
            self.labelDay.text = (viewModel?.dayOfWeek)!
            self.labelTempDay.text = (viewModel?.tempDay)!
            self.labelTempNigth.text = (viewModel?.tempNigth)!
            
            Network.shared.downloadImage(url: (viewModel?.urlImage)!) { (image) in
                self.weatherImage.image = image
            }
        }
    }
    
}
