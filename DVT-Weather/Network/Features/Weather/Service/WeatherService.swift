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
    func currentWeather(completion: @escaping CurrentWeatherCompletion<T>)
    func fiveDayWeatherForcast(completion: @escaping CurrentWeatherCompletion<T>)
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
    
    func currentWeather(completion: @escaping CurrentWeatherCompletion<T>) {
        router.request(route: .currentWeather, logContent: true, completion: completion)
    }
    
    func fiveDayWeatherForcast(completion: @escaping CurrentWeatherCompletion<T>) {
        router.request(route: .fiveDaysForcast, logContent: true, completion: completion)
    }
}
