//
//  NarodMonViewCell.swift
//  Tempo
//
//  Created by Devolper on 20.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit

class NarodMonViewCell: UITableViewCell {
    
    @IBOutlet weak var lebelAdress: UILabel!
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    
    weak var viewModel: NmCellViewModel! {
        didSet {
            lebelAdress.text = viewModel.deviceAdress
            labelData.text = viewModel.deviceData
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
