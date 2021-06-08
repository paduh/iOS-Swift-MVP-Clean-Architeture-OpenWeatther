//
//  JSONParameterEncoder.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation


public struct JSONParameterEncoder: ParameterEncoder {
    
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Accept") == nil || (urlRequest.value(forHTTPHeaderField: "Content-Type") != nil) {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
