//
//  ApiService.swift
//  Services
//
//  Created by 박서연 on 2024/10/22.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation
import Combine
import Common

public class ApiService {
    
    public var cancellables = Set<AnyCancellable>()
    public init() { }
    
    public func request (
        httpMethod: ApiMethod,
        endPoint: String,
        queryParameters: Encodable? = nil,
        pathParameters: String? = nil,
        body: Encodable? = nil,
        header: String? = nil
    ) -> AnyPublisher<Data, NetworkError> {
        
        var modifiedEndPoint = endPoint
        
        if let pathParameter = pathParameters {
            modifiedEndPoint = modifiedEndPoint + "/\(pathParameter)"
        }
        
        guard var url = URL(string: modifiedEndPoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        if let parameters = queryParameters {
            guard let queryDictionary = try? parameters.toDictionary() else {
                return Fail(error: NetworkError.queryError).eraseToAnyPublisher()
            }
            
            var queryItems: [URLQueryItem] = []
            
            queryDictionary.forEach({ key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            })
            
            url.append(queryItems: queryItems)
        }
        
        debugPrint("🚨🚨 <<<EndPoint>>> \(modifiedEndPoint) 🚨🚨")
        debugPrint("🚨🚨 <<<URL>>> \(url) 🚨🚨")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let header = header {
            urlRequest.allHTTPHeaderFields = createHeaders(token: header)
            debugPrint("🚨🚨 <<<ˆHTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
        }
        
        if let body = body {
            do {
                let httpBody = try JSONEncoder().encode(body)
                urlRequest.httpBody = httpBody
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                debugPrint("🚨🚨 <<<HTTP BODY>>> \(body) 🚨🚨")
                debugPrint("🚨🚨 <<<HTTP HTTPBODY>>> \(httpBody) 🚨🚨")
                debugPrint("🚨🚨 <<<HTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
            } catch {
                return Fail(error: NetworkError.encodingFailed).eraseToAnyPublisher()
            }
        }
        
        debugPrint("🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵🩵")
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.responseError
                }
                
                let statusCode = httpResponse.statusCode
                print("🚨🚨 <<<STATUS CODE>>> \(statusCode) 🚨🚨")
                
                guard (200..<300).contains(statusCode) else {
                    throw NetworkError.statusError(statusCode: statusCode)
                }
                return data
            }
            .decode(type: Data.self, decoder: JSONDecoder())
            .mapError { error in
                print("🚨🚨 <<<ERROR>>> \(error.localizedDescription) 🚨🚨")
                return (error as? NetworkError) ?? NetworkError.requestFailed(error: error)
            }
            .eraseToAnyPublisher()
    }
}

public extension ApiService {
    func createHeaders(token: String) -> [String : String] {
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json; charset=utf-8",
            "Accept-Charset": "UTF-8"
        ]
    }
}
