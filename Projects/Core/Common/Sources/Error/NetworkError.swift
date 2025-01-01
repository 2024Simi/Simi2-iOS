//
//  servicedumy.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(error: Error)
    case responseError
    case statusError(statusCode: Int)
    case dataNotFound
    case queryError
    case encodingFailed
    case decodingFailed
    case unauthorized
    case forbidden
    case noInternetConnection
    case timeout
    case unknown(error: Error)
    case serverStatus(status: Bool)
    case wrongMapper
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed(let error):
            return "The request failed: \(error.localizedDescription)"
        case .responseError:
            return "Server responded with an error"
        case .statusError(let statusCode):
            return "Server Status responded with an error: \(statusCode)"
        case .dataNotFound:
            return "No data received from the server."
        case .queryError:
            return "Wrong Query Request"
        case .decodingFailed:
            return "Failed to decode the response"
        case .unauthorized:
            return "You are not authorized to access this resource."
        case .forbidden:
            return "Access to this resource is forbidden."
        case .noInternetConnection:
            return "No internet connection. Please check your network."
        case .timeout:
            return "The request timed out. Please try again later."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        case .encodingFailed:
            return "Fail to Encoding."
        case .serverStatus(let status):
            return "Server Status, is \(status)"
        case .wrongMapper:
            return "Wrong Mapper"
        }
    }
}
