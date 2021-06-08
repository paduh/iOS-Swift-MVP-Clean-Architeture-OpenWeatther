//
//  NetworkRouter.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation

// MARK:- Network Router

protocol NetworkRouter {
    
    associatedtype EndPoint: EndPointType
    associatedtype T: Codable
    
    typealias NetworkRouterCompletion = ((Result<T>) ->())
    
    func request(route: EndPoint, logContent: Bool, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

// MARK:- Generic Network Router Result

enum Result<T: Codable> {
    case success(_ data: T)
    case failure(_ error: NetworkResponse)
}
