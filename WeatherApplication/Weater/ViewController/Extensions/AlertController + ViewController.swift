//
//  AlertController + ViewController.swift
//  WeatherApplication
//
//  Created by Кирилл Тарасов on 12.10.2021.
//

import UIKit


extension ViewController {
    
    @objc func presentSearchAlertController() {
        let alertController = UIAlertController(title: "Enter city name", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            let cities = ["Moscow","Volgograd","Frolovo"]
            textField.clearButtonMode = .whileEditing
            textField.autocorrectionType = .default
            textField.font = UIFont(name: "Avenir", size: 15)
            textField.placeholder = cities.randomElement()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName.isEmpty == false {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
                self.activityIndicatorItem.startAnimating()
                self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "location")
            }
        }
        alertController.addAction(cancel)
        alertController.addAction(search)
        present(alertController, animated: true, completion: nil)
    }
}

