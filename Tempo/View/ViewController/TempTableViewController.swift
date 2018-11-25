//
//  TempTableViewController.swift
//  Tempo
//
//  Created by Devolper on 24.10.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit

class TempTableViewController: UITableViewController {
    
    //let xuAPI = XuAPI()
    
    private var firstAppearenc = true
    
    // viewModel
    var viewModel: XuViewModel! {
        didSet {  // when change viewModal -> update weather
            viewModel.updateWeather(completion: { (currentViewModel) in
                (self.tableView as! TableView).viewModel = currentViewModel
                self.navigationItem.title = currentViewModel.city
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = XuViewModel() //may be move to AppDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard firstAppearenc else { return }
        firstAppearenc = false
        launchAnimate()
    }

    
    func launchAnimate () {
        let launchView = UIView(frame: self.view.bounds)
        launchView.backgroundColor = .white
        self.view.addSubview(launchView)
        
        let launchImage = UIImageView(frame: launchView.bounds)
        launchImage.image = #imageLiteral(resourceName: "logo_termo")
        launchImage.contentMode = .scaleAspectFit
        launchImage.layer.opacity = 1
        launchView.addSubview(launchImage)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
            launchImage.transform = CGAffineTransform(scaleX: 8, y: 8)
            launchImage.layer.opacity = 0
        }) { (isEnd) in
            launchView.removeFromSuperview()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("[Xu] : ReloadTabel - \(self.viewModel.getXuCountOfCell())")
        return self.viewModel.getXuCountOfCell()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idForecastCell", for: indexPath) as! TempTableViewCell
        cell.viewModel = viewModel.getXuCellViewModel(index: indexPath.row)
        return cell
    }

}

