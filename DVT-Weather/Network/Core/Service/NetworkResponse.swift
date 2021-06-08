//
//  NetworkResponse.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation

// MARK:- Network Response

enum NetworkResponse {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed, noData, unableToDecode
    case noNetworkConnection
    case custom(info: String)
    
    var title: String {
        switch self {
        case .success:
            return "You need to be authenticated first."
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Well this is embarrassing... The service is unavailable at the moment. Please try again later."
        case .outdated:
            return "Well this is embarrassing.. The service is unavailable at the moment, we're working on a fix so please try again later."
        case .failed, .noData, .unableToDecode:
            return "Well this is embarrassing.. The service is unavailable at the moment. Please try again later."
        case .noNetworkConnection:
            return "Please check your internet connection and try again"
        case .custom(let info):
            return info
        }
    }
}
