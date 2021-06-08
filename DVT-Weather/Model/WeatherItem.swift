//
//  WeatherItem.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import UIKit

// MARK: - WeatherItem

class WeatherItem {
    
    // MARK: Properties
    var list: List
    
    
    // MARK: Initializer
    
    init(model: List) {
        self.list = model
    }
}

// MARK: - Helpers

extension WeatherItem {
    
    var forcastDate: String {
        let dt = list.dtTxt ?? ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatedDate: Date = dateFormatterGet.date(from: dt) else { return "" }
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        let dateString = dateFormatterPrint.string(from: formatedDate)
        return dateString
    }
    
    var temperature: String {
        guard let temp =  list.main?.temp?.celciusTemp else { return "" }
        return temp
    }
    
    var weatherImage: UIImage? {
        guard let main = list.weather?.first?.main else { return UIImage() }
        guard let name = WeatherType(rawValue: main) else { return UIImage() }
        switch name {
        case .clear: return R.image.clear()
        case .clouds: return R.image.sea_cloudy()
        case .rain: return R.image.rain()
        }
    }
}
