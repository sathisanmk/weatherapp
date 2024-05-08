//
//  WeatherViewModel.swift
//  WeatherApplication
//
//  Created by Sathishkumar Muthukumar on 08/05/24.
//

import Foundation

class WeatherViewModel {
    private let networkService: NetworkService
    
    var weatherData: WeatherModel?
    
    var onFetchWeatherSuccess: (() -> Void)?
    var onFetchWeatherError: ((Error) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func getWeatherData(location: String) {
        var network = WeatherRequest()
        network.location = location
        
        networkService.request(network) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.weatherData = weather
                self?.onFetchWeatherSuccess?()
            case .failure(let error):
                self?.onFetchWeatherError?(error)
            }
        }
    }
    
    func getTemperature() -> String {
        return "\(weatherData?.main.temp ?? 0) º"
    }
    
    func getHumidity() -> String {
        return "\(weatherData?.main.humidity ?? 0) %"
    }
    
    func getImageURL() -> URL {
        let urlString = "https://openweathermap.org/img/wn/\(self.weatherData?.weather.first?.icon ?? "")@2x.png"
        
        guard let url = URL(string: urlString) else { return URL(string: "https://openweathermap.org/img/wn/10d@2x.png")!}
        
        return url
    }
}
