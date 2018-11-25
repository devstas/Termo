//
//  allTempViewController.swift
//  Tempo
//
//  Created by Devolper on 18.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit
import CoreLocation

class SensorsViewController: UITableViewController, UITabBarControllerDelegate {

    let narodMonitor = NarodMonAPI()
    
    let cellDefaultHeigth = 50, cellMarginLeft = 50
    var newCellHeigth = 50
    var selectedCell : Int? = nil, indexCellClick: Int? = nil
    
    var viewModel: NmViewModel! {
        didSet{
            viewModel.getDataSensor {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func bntInfoPess(_ sender: UIButton) {
        if selectedCell != sender.tag {
            selectedCell = sender.tag
            print("Раскрытие ячейки номер - \(selectedCell!)")
        } else {
            selectedCell = nil
            print("Скрытие ячейки \(sender.tag)  - selectedCell = nil.  ")
            
        }
        tableView.reloadData()
        //tableView.reloadRows(at: [ IndexPath(item: sender.tag, section: 1)], with: .none)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        lableDiscription.layer.anchorPoint = CGPoint(x: 0, y: 0)
        self.viewModel = NmViewModel()
//        loginInNarodMon()
//        narodMonitor.appInit { (data) in
//        }
    }
    

    func loginInNarodMon() {
        narodMonitor.userLogon { (data) in
            if data.uid != nil {
                print("login:\(String(describing: data.login!)) uid: \(String(describing: data.uid))")
            } else {
                print("login:\(String(describing: data.login!))")
            }
         // Loginus - ok
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("[NarodMon]: tabelCount - \(viewModel.getNmCountOfCell())")
        return viewModel.getNmCountOfCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ближайшие датчики:"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Remove lableDiscription, можно переписать и не удалять а скрывать
        if selectedCell == nil && lableDiscription.superview != nil {
            lableDiscription.removeFromSuperview()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "idNarodCell", for: indexPath) as! NarodMonViewCell
        
        cell.viewModel = self.viewModel.getNmCellViewModel(index: indexPath.row)
        cell.btn.tag = indexPath.row
        return addDiscriptionLabel(cell: cell, index: indexPath.row)
    }
 
    let  lableDiscription = UILabel()
    
    func addDiscriptionLabel(cell: UITableViewCell, index: Int) -> UITableViewCell {
        if index == selectedCell {
            
            let width = Int(cell.frame.width)

            lableDiscription.frame = CGRect(x: cellMarginLeft, y: cellDefaultHeigth-8, width: width-(2 * cellMarginLeft), height: cellDefaultHeigth)
            lableDiscription.textAlignment = .left
            lableDiscription.font = lableDiscription.font.withSize(15)
  
            lableDiscription.text = viewModel.getNmCellViewModel(index: index).deviceExtendedData
            lableDiscription.isHidden = false
            lableDiscription.isEnabled = false
            lableDiscription.numberOfLines = 0
            lableDiscription.lineBreakMode = .byWordWrapping
            lableDiscription.sizeToFit()
            newCellHeigth = Int(lableDiscription.frame.height + CGFloat(cellDefaultHeigth))
            
            cell.addSubview(lableDiscription)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCell != nil {
            if indexPath.row == selectedCell {
                //print("меняем высоту у ячейки \(selectedCell)")
                return CGFloat(newCellHeigth)
            } else {
                return CGFloat(cellDefaultHeigth)
            }
        } else {
            return CGFloat(cellDefaultHeigth)
        }
    }
    
    //анимация с вращением
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedCell != nil && selectedCell == indexPath.row {
            
            //анимация с вращением
            let degree: Double = 90
            let rotationAndle = CGFloat(degree * Double.pi / 180)
            let rotationTransform = CATransform3DMakeRotation(rotationAndle, 1, 1, 0)
            lableDiscription.layer.transform = rotationTransform
            lableDiscription.layer.opacity = 0.3
            //lableDiscription.layer.anchorPoint = CGPoint(x: 0, y: 0) - в wieDidLoad
            UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: {
                self.lableDiscription.layer.opacity = 1
                self.lableDiscription.layer.transform =  CATransform3DIdentity
            })
            
            //анимация с прозрачностью
            //            lableDiscription.layer.opacity = 0.1
            //            UIView.animate(withDuration: 0.6) {
            //                self.lableDiscription.layer.opacity = 1
            //            }
            
        }
    }

}
