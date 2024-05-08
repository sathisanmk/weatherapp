//
//  WeatherRequest.swift
//  WeatherApplication
//
//  Created by Sathishkumar Muthukumar on 08/05/24.
//

import Foundation

struct WeatherRequest: DataRequest {
    typealias Response = WeatherModel
    
    private let apiKey: String = NetworkConstants.apiKey
    
    var location: String = ""
    
    var url: String {
        let baseURL: String = NetworkConstants.baseURL
        let path: String = NetworkConstants.getWeather
        return baseURL + path
    }
    
    var queryItems: [String : String] {
        [
            GetWeatherParams.appid: apiKey,
            GetWeatherParams.location: location,
            GetWeatherParams.units: GetWeatherParams.unitValue
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> WeatherModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let response = try decoder.decode(WeatherModel.self, from: data)
        return response
    }
}
