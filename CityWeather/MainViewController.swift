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
//-------> to register long press
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
//-------> to add to view
        self.view.addGestureRecognizer(longPressRecognizer)
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
//-------> to add info button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoItemTapped))
    }
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer){
        print("Long Press tapped")
        basicActionSheet(title: "Long Press Info", message: "Hello!")
    }
    
    @objc private func infoItemTapped(){
        print("Info tapped")
        basicAlert(title: "Info", message: "Hi There!")
    }
}

extension  MainViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        cell.textLabel?.text = "List"
        cell.detailTextLabel?.text = "Name"
//-------> to remove marking/selection style
        cell.selectionStyle = .none
        return cell
    }
}
//-------> to add an alert controller
extension  MainViewController{
    func basicAlert(title: String?, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func basicActionSheet(title: String?, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
