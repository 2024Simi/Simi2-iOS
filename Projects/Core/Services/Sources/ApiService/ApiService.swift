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
    
    public func request<T: Decodable> (
        httpMethod: ApiMethod,
        endPoint: String,
        queryParameters: Encodable? = nil,
        pathParameters: String? = nil,
        body: Encodable? = nil,
        header: String? = nil
    ) -> AnyPublisher<T, NetworkError> {
        
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
            .handleEvents(receiveOutput: { data, _ in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("🚨🚨 <<<Raw JSON Response>>> \(jsonString) 🚨🚨")
                }
            })
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.responseError
                }
                
                let statusCode = httpResponse.statusCode
                print("🚨🚨 <<<STATUS CODE>>> \(statusCode) 🚨🚨")
                print("🚨🚨 <<<Data>>> \(data) 🚨🚨")
//                guard (200..<300).contains(statusCode) else {
//                    throw NetworkError.statusError(statusCode: statusCode)
//                }
                return data
            }
            .decode(type: Response<T>.self, decoder: JSONDecoder()) // Decode to Response<T>
            .handleEvents(receiveOutput: { response in
                print("🚨🚨 <<<Decoded Response>>> \(response) 🚨🚨")
            })
            .tryMap { response in
                guard let data = response.data else {
                    print("🚨🚨 <<<Response Data is nil>>> 🚨🚨")
                    throw NetworkError.responseError
                }
                
                print("DATA \(data)")
                return data
            }
            .mapError { error in
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
