//
//  URL.swift
//  WeatherInfo
//
//  Created by Suhyoung Eo on 2022/01/18.
//

import Foundation

extension URL {
    
    static func urlForWeatherApi(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=/* API Key */&units=metric&lang=kr&q=\(city)")
    }
}
