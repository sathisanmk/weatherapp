//
//  Extensions.swift
//  WeatherApplication
//
//  Created by Sathishkumar Muthukumar on 08/05/24.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.isHidden = false
                    }
                }
            }
        }
    }
}
