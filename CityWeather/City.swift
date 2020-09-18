//
//  City.swift
//  CityWeather
//
//  Created by Inga Kirsona on 17/09/2020.
//  Copyright © 2020 Inga Kirsona. All rights reserved.
//

import Foundation

struct City {
    let name: String?
    let capital: String?
    let region: String?
//-------> to access exact name from Json code, need to initialize, "any" - data are not only string, also bool, int.
        init (item:[String: Any]){
            name = item ["name"] as? String
            capital = item ["capital"] as? String
            region = item ["region"] as? String
    }
//-------> to present every country in array from Json code
    static func getArray(from arrayOfItems: Any)-> [City]? {
        guard let arrayOfCityItems = arrayOfItems as? Array<[String: Any]> else {return nil}
        return arrayOfCityItems.compactMap{City(item: $0)}
    }
}

