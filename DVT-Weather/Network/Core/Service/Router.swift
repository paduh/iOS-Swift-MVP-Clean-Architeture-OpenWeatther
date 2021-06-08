//
//  Router.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 05/06/2021.
//

import Foundation
import UIKit


class Router<EndPoint: EndPointType, T: Codable>: NSObject, NetworkRouter, URLSessionDelegate {
    private var task: URLSessionTask?
    typealias NetworkRouterCompletion = ((Result<T?>)->())
    
    func request(route: EndPoint, logContent: Bool = true, completion: @escaping NetworkRouterCompletion) {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 90.0
        sessionConfig.timeoutIntervalForResource = 90.0
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        do {
            let request = try self.buildRequest(from: route)
            print(request.url)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkResponse.noNetworkConnection))
                    }
                    return
                }
                if let response = response as? HTTPURLResponse {
                    let result = response.handleNetworkResponse()
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                            guard let responseData = data else {
                                completion(.failure(NetworkResponse.noData))
                                return
                            }
                            do {
                                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                                completion(.success(apiResponse))
                            }catch {
                                print(error)
                                completion(.failure(NetworkResponse.unableToDecode))
                            }
                        case .failure(let error):
                            completion(.failure(.custom(info: error)))
                        }
                    }
                }
            })
        } catch let error {
            DispatchQueue.main.async {
                completion(.failure(.custom(info: error.localizedDescription)))
            }
        }
        self.task?.resume()
    }
    
    func cancel() {
        
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .imageUpload(let image, let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try request.setMultipartBodyImage(image)
                
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let trust = challenge.protectionSpace.serverTrust {
                completionHandler(.useCredential, URLCredential(trust: trust))
            }
        }
    }
}


extension URLRequest {
    
    /**
     Configures the URL request for `multipart/form-data`. The request's `httpBody` is set, and a value is set for the HTTP header field `Content-Type`.
     
     - Parameter parameters: The form data to set.
     - Parameter encoding: The encoding to use for the keys and values.
     
     - Throws: `MultipartFormDataEncodingError` if any keys or values in `parameters` are not entirely in `encoding`.
     
     - Note: The default `httpMethod` is `GET`, and `GET` requests do not typically have a response body. Remember to set the `httpMethod` to e.g. `POST` before sending the request.
     - Seealso: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#multipart-form-data
     */
    public mutating func setMultipartBodyImage(_ image: UIImage) throws {
        
        let makeRandom = { UInt32.random(in: (.min)...(.max)) }
        let boundary = String(format: "------------------------%08X%08X", makeRandom(), makeRandom())
        let filename = "image.jpg"
        
        let contentType = "multipart/form-data; boundary=\(boundary)"
        setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        httpBody =  {
            var data = Data()
            
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(image.jpegData(compressionQuality: 0.5)!)
            
            // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
            // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            
            return data
            }()
    }
}

public enum MultipartFormDataEncodingError: Error {
    case name(String)
    case value(String, name: String)
}
