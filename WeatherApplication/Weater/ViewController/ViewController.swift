//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Кирилл Тарасов on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let mainWeatherView = UIView()
    let weatherIcon = UIImageView()
    let temperature = UILabel()
    let feelsLikeTemperature = UILabel()
    let weatherDescription = UILabel()
    let horizontalView = UIView()
    let horizontalStack = UIStackView()
    let pressure = UIImageView()
    let pressureValue = UILabel()
    let pressureStack = UIStackView()
    let humidity = UIImageView()
    let humidityValue = UILabel()
    let humidityStack = UIStackView()
    let windSpeed = UIImageView()
    let windSpeedValue = UILabel()
    let windSpeedStack = UIStackView()
    let activityIndicatorItem = UIActivityIndicatorView()
    
    let backgroundImage = UIImageView(image: UIImage(named: "background"))
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "City name"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Avenir Black", size: 25)!,
                          NSAttributedString.Key.foregroundColor : UIColor(named: "TextColor")]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        let leftBarActivityIndicator = UIBarButtonItem(customView: activityIndicatorItem)
        leftBarActivityIndicator.tintColor = UIColor(named: "TextColor")
        
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                              target: self,
                                              action: #selector(presentSearchAlertController))
        rightButtonItem.tintColor = UIColor(named: "TextColor")
        navigationItem.rightBarButtonItem = rightButtonItem
        
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        horizontalView.backgroundColor = .lightGray
        horizontalView.layer.cornerRadius = 25
        horizontalView.clipsToBounds = true
        view.addSubview(horizontalView)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        horizontalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        horizontalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        horizontalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(pressureStack)
        horizontalStack.addArrangedSubview(humidityStack)
        horizontalStack.addArrangedSubview(windSpeedStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.topAnchor.constraint(equalTo: horizontalView.topAnchor, constant: 20).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: -20).isActive = true
        horizontalStack.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor, constant: 20).isActive = true
        horizontalStack.trailingAnchor.constraint(equalTo: horizontalView.trailingAnchor, constant: -20).isActive = true
        
        pressureStack.axis = .vertical
        pressureStack.spacing = 5
        pressureStack.alignment = .center
        pressureStack.distribution = .fillEqually
        pressureStack.addArrangedSubview(pressure)
        pressureStack.addArrangedSubview(pressureValue)
        pressure.image = UIImage(systemName: "barometer")
        pressure.contentMode = .scaleAspectFill
        pressureValue.text = "mm"
        pressureValue.adjustsFontSizeToFitWidth = true
        pressureValue.font = UIFont(name: "Avenir-Heavy", size: 20)
        
        humidityStack.axis = .vertical
        humidityStack.spacing = 5
        humidityStack.alignment = .center
        humidityStack.distribution = .fillEqually
        humidityStack.addArrangedSubview(humidity)
        humidityStack.addArrangedSubview(humidityValue)
        humidity.image = UIImage(systemName: "drop")
        humidity.contentMode = .scaleAspectFill
        humidityValue.text = "%"
        humidityValue.adjustsFontSizeToFitWidth = true
        humidityValue.font = UIFont(name: "Avenir-Heavy", size: 20)
        
        windSpeedStack.axis = .vertical
        windSpeedStack.spacing = 5
        windSpeedStack.alignment = .center
        windSpeedStack.distribution = .fillEqually
        windSpeedStack.addArrangedSubview(windSpeed)
        windSpeedStack.addArrangedSubview(windSpeedValue)
        windSpeed.image = UIImage(systemName: "wind")
        windSpeed.contentMode = .scaleAspectFill
        windSpeedValue.text = "m/sec"
        windSpeedValue.adjustsFontSizeToFitWidth = true
        windSpeedValue.font = UIFont(name: "Avenir-Heavy", size: 20)
        
        mainWeatherView.backgroundColor = .lightGray
        mainWeatherView.layer.cornerRadius = 25
        view.addSubview(mainWeatherView)
        mainWeatherView.translatesAutoresizingMaskIntoConstraints = false
        mainWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mainWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        mainWeatherView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mainWeatherView.bottomAnchor.constraint(equalTo: horizontalView.topAnchor, constant: -10).isActive = true
        
        weatherIcon.image = UIImage(systemName: "sun.max.fill")
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.tintColor = UIColor(named: "SymbolColor")
        mainWeatherView.addSubview(weatherIcon)
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.topAnchor.constraint(equalTo: mainWeatherView.topAnchor, constant: 20).isActive = true
        weatherIcon.bottomAnchor.constraint(equalTo: mainWeatherView.bottomAnchor, constant: -20).isActive = true
        weatherIcon.leadingAnchor.constraint(equalTo: mainWeatherView.leadingAnchor, constant: 20).isActive = true
        weatherIcon.trailingAnchor.constraint(equalTo: mainWeatherView.centerXAnchor, constant: -10).isActive = true
        
        temperature.text = "°C"
        temperature.adjustsFontSizeToFitWidth = true
        temperature.numberOfLines = 0
        temperature.font = UIFont(name: "Avenir Black", size: 65)
        temperature.textColor = UIColor(named: "TextColor")
        mainWeatherView.addSubview(temperature)
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.leadingAnchor.constraint(equalTo: mainWeatherView.centerXAnchor, constant: 10).isActive = true
        temperature.trailingAnchor.constraint(equalTo: mainWeatherView.trailingAnchor, constant: -20).isActive = true
        temperature.bottomAnchor.constraint(equalTo: mainWeatherView.centerYAnchor).isActive = true
        temperature.topAnchor.constraint(equalTo: mainWeatherView.topAnchor, constant: 20).isActive = true
        
        feelsLikeTemperature.text = "Feels like"
        feelsLikeTemperature.adjustsFontSizeToFitWidth = true
        feelsLikeTemperature.numberOfLines = 0
        feelsLikeTemperature.font = UIFont(name: "Avenir", size: 15)
        feelsLikeTemperature.textColor = UIColor(named: "TextColor")
        mainWeatherView.addSubview(feelsLikeTemperature)
        feelsLikeTemperature.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeTemperature.leadingAnchor.constraint(equalTo: temperature.leadingAnchor).isActive = true
        feelsLikeTemperature.trailingAnchor.constraint(equalTo: temperature.trailingAnchor).isActive = true
        feelsLikeTemperature.topAnchor.constraint(equalTo: mainWeatherView.centerYAnchor).isActive = true
        feelsLikeTemperature.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        weatherDescription.text = "Weather description"
        weatherDescription.adjustsFontSizeToFitWidth = true
        weatherDescription.numberOfLines = 0
        weatherDescription.font = UIFont(name: "Avenir Medium", size: 20)
        weatherDescription.textColor = UIColor(named: "TextColor")
        mainWeatherView.addSubview(weatherDescription)
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.topAnchor.constraint(equalTo: feelsLikeTemperature.bottomAnchor, constant: 10).isActive = true
        weatherDescription.leadingAnchor.constraint(equalTo: feelsLikeTemperature.leadingAnchor).isActive = true
        weatherDescription.trailingAnchor.constraint(equalTo: feelsLikeTemperature.trailingAnchor).isActive = true
        weatherDescription.bottomAnchor.constraint(equalTo: mainWeatherView.bottomAnchor, constant: -20).isActive = true
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
    }
    
    @objc func updateLocation() {
        self.activityIndicatorItem.startAnimating()
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.title = weather.cityName
            self.weatherIcon.image = UIImage(systemName: weather.systemIconNameString)
            self.temperature.text = "\(weather.temperatureString)°C"
            self.feelsLikeTemperature.text = "Feels like \(weather.feelsLikeTemperatureString)°C"
            self.weatherDescription.text = weather.weatherDescription.prefix(1).capitalized +
            weather.weatherDescription.dropFirst()
            self.pressureValue.text = "\(weather.pressure) mm"
            self.humidityValue.text = "\(weather.humidity) %"
            self.windSpeedValue.text = "\(weather.windSpeed) m/sec"
            self.activityIndicatorItem.stopAnimating()
        }
    }
}
