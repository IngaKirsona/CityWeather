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
    private var cities: [City] = []
    
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
//-------> to fetch data
        NetworkManager.fetchData { citiesList in
            self.cities = citiesList
            self.tableView.reloadData()
        }
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
//-------> to start our touch and to acces indexPath.row
        if sender.state == UIGestureRecognizer.State.began{
            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint){
                basicActionSheet(title: cities[indexPath.row].name, message: cities[indexPath.row].capital)
            }
        }
    }
    
    @objc private func infoItemTapped(){
        print("Info tapped")
        basicAlert(title: "Info", message: "Long press to open an action sheet, single tap on cell to open an alert.")
    }
}

extension  MainViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.capital
        if let region = city.region{
            cell.detailTextLabel?.text! += " from region: \(region)"
        }
//-------> to remove marking/selection style
        cell.selectionStyle = .none
        return cell
    }
    
//-------> on single tap to see in alert what is written below.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        basicAlert(title: cities[indexPath.row].region, message: "Capital of \(cities[indexPath.row].name ?? "") is \(cities[indexPath.row].capital ?? "")")
    }
    
//-------> to have an animation when scrolling 
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.5){
            cell.transform = CGAffineTransform.identity
        }
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
