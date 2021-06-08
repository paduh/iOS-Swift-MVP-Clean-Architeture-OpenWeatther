//
//  EndPointType.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation

protocol EndPointType {
    
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
