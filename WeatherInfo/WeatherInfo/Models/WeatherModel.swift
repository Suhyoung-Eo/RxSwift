//
//  WeatherModel.swift
//  WeatherInfo
//
//  Created by Suhyoung Eo on 2022/01/18.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

extension WeatherModel {
    
    static var empty: WeatherModel {
        
        return WeatherModel(weather: [Weather(id: 0,
                                              main: "",
                                              description: "",
                                              icon: "")],
                            main: Main(temp: 0.0,
                                       feels_like: 0.0,
                                       temp_min: 0.0,
                                       temp_max: 0.0,
                                       pressure: 0.0,
                                       humidity: 0.0),
                            name: "")
    }
}
