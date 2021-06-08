//
//  WeatherService.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation

// MARK:- Payment Methods Completion

typealias CurrentWeatherCompletion<T: Codable> = ((Result<T?>)->())

// MARK:- Payment Methods ServiceDelegate

protocol CurrentWeatherCompletionServiceDelegate {
    associatedtype T: Codable
    func currentWeather(lat: Double, long: Double, completion: @escaping CurrentWeatherCompletion<T>)
    func fiveDayWeatherForcast(lat: Double, long: Double, completion: @escaping CurrentWeatherCompletion<T>)
}

// MARK:- Payment Methods Service

class WeatherService<T: Codable> {
    
    // MARK: Properties
    
    var router: Router<WeatherEndPoint, T>!
    
    // MARK: Initializer / DeInitializer
    
        init(router: Router<WeatherEndPoint, T> = Router<WeatherEndPoint, T>()) {
        self.router = router
    }
}

// MARK:- Payment Methods Service & Payment Methods Service Delegate

extension WeatherService: CurrentWeatherCompletionServiceDelegate {
    
    func currentWeather(lat: Double, long: Double, completion: @escaping CurrentWeatherCompletion<T>) {
        router.request(route: .currentWeather(lat, long), logContent: true, completion: completion)
    }
    
    func fiveDayWeatherForcast(lat: Double, long: Double, completion: @escaping CurrentWeatherCompletion<T>) {
        router.request(route: .fiveDaysForcast(lat, long), logContent: true, completion: completion)
    }
}
