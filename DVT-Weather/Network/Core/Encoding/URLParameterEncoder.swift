//
//  URLParameterEncoder.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation

// MARK:- URLParameterEncoder

struct URLParameterEncoder: ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL}
        if var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponent.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponent.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponent.url
        }
        if urlRequest.value(forHTTPHeaderField: "Accept") == nil || (urlRequest.value(forHTTPHeaderField: "Content-Type") != nil) {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Accept")
        }
    }
}
