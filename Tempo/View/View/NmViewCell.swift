//
//  NarodMonViewCell.swift
//  Tempo
//
//  Created by Serov Stas on 20.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit

class NarodMonViewCell: UITableViewCell {
    
    @IBOutlet weak var lebelAdress: UILabel!
    @IBOutlet weak var labelData: UILabel!
    
    weak var viewModel: NmCellViewModel! {
        didSet {
            lebelAdress.text = viewModel.deviceAdress
            labelData.text = viewModel.deviceData
        }
    }
    

}
