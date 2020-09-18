//
//  NetworkManager.swift
//  CityWeather
//
//  Created by Inga Kirsona on 18/09/2020.
//  Copyright © 2020 Inga Kirsona. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    
    static private let jsonUrl = "https://restcountries.eu/rest/v2/all"
    static func fetchData(completion: @escaping ([City]) -> ()){
        AF.request(jsonUrl).validate().responseJSON { (jsonData) in
            switch jsonData.result{
            case .success(let value):
                let cities = City.getArray(from: value)
                completion(cities ?? [])
            case .failure(let error):
                print("Error: ", error)
            }
        }
    }
}
