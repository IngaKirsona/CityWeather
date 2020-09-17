//
//  AppDelegate.swift
//  CityWeather
//
//  Created by Inga Kirsona on 17/09/2020.
//  Copyright © 2020 Inga Kirsona. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//-------> everuthing that simulator can show
        window = UIWindow(frame: UIScreen.main.bounds)
//-------> make window visible
        window?.makeKeyAndVisible()
        
//-------> embed in navigation controller
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        
        
        return true
    }

    

}

