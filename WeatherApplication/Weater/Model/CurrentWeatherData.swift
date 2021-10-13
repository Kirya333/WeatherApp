//
//  CurrentWeatherData.swift
//  WeatherApplication
//
//  Created by Кирилл Тарасов on 12.10.2021.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp, feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
    }
}

struct Weather: Codable {
    let id: Int
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
    }
}

struct Wind: Codable {
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case windSpeed = "speed"
    }
}
