//
//  AppConstants.swift
//  WeatherApplication
//
//  Created by Sathishkumar Muthukumar on 08/05/24.
//

import Foundation

struct NetworkConstants {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "6756a43a2d6430ed6bba486e59f89e33"
    static let getWeather = "weather"
}

struct GetWeatherParams {
    static let appid = "appid"
    static let location = "q"
    static let units = "units"
    static let unitValue = "metric"
}

struct ValidationError {
    static let error = "Error"
    static let ok = "Ok"
    static let locationEmpty = "Location should not be empty"
}
