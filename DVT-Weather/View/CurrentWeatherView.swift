//
//  CurrentWeatherView.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import Foundation

// MARK: - WeatherView

public protocol WeatherView: class {
    func showLoadingStatus()
    func hideLoadingStatus()
    func show(title aTitle: String)
    func show(currentWeather: CurrentWeather)
    func showErrorWith(message: String)
    func show(fiveDaysWeather: FiveDaysWeather)
    func showEmptyState()
}
