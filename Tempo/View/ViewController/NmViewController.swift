//
//  NmViewController.swift
//  Tempo
//
//  Created by Serov Stas on 18.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit
import CoreLocation


class NmViewController: UITableViewController {
    
    var selectedCell: Int? = 0
    
    var viewModel: NmViewModel! {
        didSet{
            viewModel.getDataSensor { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        LocationManager.shered.requestLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lableDiscription.layer.anchorPoint = CGPoint(x: 0, y: 0)
        NotificationCenter.default
            .addObserver(self, selector: #selector(updateSensors(_:)), name: .locationIsUpdate, object: nil)
        updateSensors((Any).self)
    }
    
    @objc func updateSensors(_ sender: Any) {
        self.viewModel = NmViewModel()
    }
    
    // MARK: - Table view: data source, delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel != nil ? self.viewModel!.getNmCountOfCell() : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Remove lableDiscription, if necessary
        if selectedCell == nil && lableDiscription.superview != nil {
            lableDiscription.removeFromSuperview()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "idNarodCell", for: indexPath) as! NarodMonViewCell
        if viewModel != nil {
            cell.viewModel = self.viewModel.getNmCellViewModel(index: indexPath.row)
        }
        return addDiscriptionLabel(cell: cell, index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard selectedCell != nil else { return cellDefaultHeigth }
        return indexPath.row == selectedCell ? newCellHeigth : cellDefaultHeigth
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = selectedCell != indexPath.row ? indexPath.row : nil
        tableView.reloadData()
    }

    //MARK: - disclosure lableDiscription in Cell
    let cellDefaultHeigth: CGFloat = 50
    let cellMarginLeft: CGFloat = 30
    var newCellHeigth: CGFloat = 50
    
    let  lableDiscription = UILabel()
    func addDiscriptionLabel(cell: UITableViewCell, index: Int) -> UITableViewCell {
        if index == selectedCell {
            guard let deviceExtendedData = viewModel?.getNmCellViewModel(index: index).deviceExtendedData else {
                return cell
            }
            let width = cell.frame.width
            lableDiscription.frame = CGRect(x: cellMarginLeft, y: cellDefaultHeigth-4, width: width-(2 * cellMarginLeft), height: cellDefaultHeigth)
            lableDiscription.textAlignment = .left
            lableDiscription.font = lableDiscription.font.withSize(15)
            lableDiscription.text = deviceExtendedData
            lableDiscription.isHidden = false
            lableDiscription.isEnabled = false
            lableDiscription.numberOfLines = 0
            lableDiscription.lineBreakMode = .byWordWrapping
            lableDiscription.sizeToFit()
            newCellHeigth = lableDiscription.frame.height + cellDefaultHeigth
            cell.addSubview(lableDiscription)
        }
        return cell
    }
    
    //MARK: - Animate with rotation
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedCell != nil && selectedCell == indexPath.row {
            let degree: Double = 90
            let rotationAndle = CGFloat(degree * Double.pi / 180)
            let rotationTransform = CATransform3DMakeRotation(rotationAndle, 1, 1, 0)
            lableDiscription.layer.transform = rotationTransform
            lableDiscription.layer.opacity = 0.3
            UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: {
                self.lableDiscription.layer.opacity = 1
                self.lableDiscription.layer.transform =  CATransform3DIdentity
            })
        }
    }
    
}
