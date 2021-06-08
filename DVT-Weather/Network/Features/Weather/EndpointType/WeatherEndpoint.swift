//
//  WeatherEndPoint.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation

// MARK:- PaymentMethodsEndPoint

enum WeatherEndPoint {
    
    case currentWeather(Double, Double)
    case fiveDaysForcast(Double, Double)
}

extension WeatherEndPoint: EndPointType {
    var baseUrl: URL {
        return URL(string: "https://api.openweathermap.org/")! // TODO Refactor the baseurl and place it in Info.plist
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "data/2.5/weather"
        case .fiveDaysForcast:
            return "data/2.5/forecast"
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .currentWeather, .fiveDaysForcast:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .currentWeather(let lat, let long):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParam(lat: lat, long: long))
        case .fiveDaysForcast(let lat, let long):

            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParam(lat: lat, long: long))
        }
    }
    
    func urlParam(lat: Double, long: Double) -> [String: Any] {
        [
            "lat": lat,
            "lon": long,
            "appid": "466e8d514785dd9c0cebf4841eb42373"
        ]
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .currentWeather, .fiveDaysForcast:
            return nil
        }
    }
}
