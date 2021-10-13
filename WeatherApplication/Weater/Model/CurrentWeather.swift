//
//  CurrentWeather.swift
//  WeatherApplication
//
//  Created by Кирилл Тарасов on 12.10.2021.
//

import Foundation


struct CurrentWeather {
    
    let cityName: String
    var weatherDescription: String
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let conditionalCode: Int
    var systemIconNameString: String {
        switch conditionalCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...331: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "exclamationmark.icloud.fill"
        }
    }
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        conditionalCode = currentWeatherData.weather.first!.id
        weatherDescription = currentWeatherData.weather.first!.weatherDescription
        pressure = (currentWeatherData.main.pressure * 100) / Int(133.3224)
        humidity = currentWeatherData.main.humidity
        windSpeed = currentWeatherData.wind.windSpeed
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        cityName = currentWeatherData.name
    }
}
