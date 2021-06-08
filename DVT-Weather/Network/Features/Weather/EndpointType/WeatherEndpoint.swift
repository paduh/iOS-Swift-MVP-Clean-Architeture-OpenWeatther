//
//  WeatherEndPoint.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation

// MARK:- PaymentMethodsEndPoint

enum WeatherEndPoint {
    
    case currentWeather
    case fiveDaysForcast
}

extension WeatherEndPoint: EndPointType {
    var baseUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/")! // TODO Refactor the baseurl and place it in Info.plist
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "optile/checkout-android/develop/shared-test/lists/listresult.json"
        case .fiveDaysForcast:
            return "optile/checkout-android/develop/shared-test/lists/listresult.json"
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
        case .currentWeather, .fiveDaysForcast:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .currentWeather, .fiveDaysForcast:
            return nil
        }
    }
}
