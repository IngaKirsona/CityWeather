//
//  ViewController.swift
//  CityWeather
//
//  Created by Inga Kirsona on 17/09/2020.
//  Copyright © 2020 Inga Kirsona. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    private let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.allowsSelectionDuringEditing = false
//-------> to register tableview
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
       
    }
    private func setupNavigationBar(){
        navigationItem.title = "Weather in Cities"
//-------> to set an image to navigation bar, if ios version is greater than 13.0
        if #available (iOS 13.0, *){
            let titleImage = UIImage(systemName: "cloud.sun.fill")
            let imageView = UIImageView(image: titleImage)
            self.navigationItem.titleView = imageView
        }
//-------> to have a large title in black color
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}

