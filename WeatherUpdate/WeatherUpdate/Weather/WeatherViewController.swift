//
//  WeatherViewController.swift
//  WeatherApplication
//
//  Created by Sathishkumar Muthukumar on 08/05/24.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var viewModel:WeatherViewModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let networkService = NetworkService()
        viewModel = WeatherViewModel(networkService: networkService)
        hideShowLabels(status: true)
        subscribeWeatherAPI()
    }
    
    private func subscribeWeatherAPI() {
        viewModel?.onFetchWeatherSuccess = { [weak self] in
            DispatchQueue.main.async { [self] in
                self?.locationLabel.text = self?.viewModel?.weatherData?.name
                self?.weatherImage.load(url: (self?.viewModel?.getImageURL())!)
                
                self?.temperatureLabel.text = self?.viewModel?.getTemperature()
                self?.humidityLabel.text = self?.viewModel?.getHumidity()
                self?.hideShowLabels(status: false)
            }
        }
        
        viewModel?.onFetchWeatherError = { error in
            DispatchQueue.main.async {
                self.hideShowLabels(status: true)
            }
        }
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let location = searchTextField.text else { return }
        if !location.isEmpty {
            viewModel?.getWeatherData(location: searchTextField.text ?? "")
        } else {
            let alert = UIAlertController(title: ValidationError.error, message: ValidationError.locationEmpty, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ValidationError.ok, style: .default))
            self.present(alert, animated: true)
        }
    }
    
    private func hideShowLabels(status: Bool) {
        locationLabel.isHidden = status
        temperatureLabel.isHidden = status
        humidityLabel.isHidden = status
        weatherImage.isHidden = status
    }
}
