//
//  XuTableViewController.swift
//  Tempo
//
//  Created by Serov Stas on 24.10.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit


class XuTableViewController: UITableViewController {
    
    private var firstAppearenc = true

    var viewModel: XuViewModel! {
        didSet {
            viewModel.updateWeather { [weak self] (headerViewModel) in
                (self?.tableView as! XuTableView).viewModel = headerViewModel
                self?.navigationItem.title = headerViewModel.city
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(self, selector: #selector(updateWeather(_:)), name: .locationIsUpdate, object: nil)
    }
    
    @objc func updateWeather(_ sender: Any) {
        self.viewModel = XuViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard firstAppearenc else { return }
        firstAppearenc = false
        launchAnimate ()
    }
    
    func launchAnimate () {
        let launchView = UIView(frame: UIScreen.main.bounds)
        launchView.backgroundColor = .white
        self.view.superview!.addSubview(launchView)
        let launchImage = UIImageView(frame: launchView.bounds)
        launchImage.image = #imageLiteral(resourceName: "logo_termo")
        launchImage.contentMode = .scaleAspectFit
        launchImage.layer.opacity = 0.8
        launchView.addSubview(launchImage)

        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            launchImage.transform = CGAffineTransform(scaleX: 7, y: 7)
            launchImage.layer.opacity = 0
        }) { (isEnd) in
            launchView.removeFromSuperview()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel != nil ? self.viewModel!.getXuCountOfCell() : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idForecastCell", for: indexPath) as! TempTableViewCell
        
        if viewModel != nil {
            cell.viewModel = viewModel!.getXuCellViewModel(index: indexPath.row)
        }
        return cell
    }

}


