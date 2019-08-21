//
//  ApiError.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

public enum ApiError: Error {
    case timeout
    case serverError
    case notFound(error: Error?)
    case unauthorized(error: Error?)
    case badRequest(error: Error?)
    case unprocessableEntity(error: Error?)
    case decodingFailed
    case nilData
    case parametersShouldHaveValue
    case unknown
    case custom(message: String)
    
    init(statusCode: Int, error: Error?) {
        switch statusCode {
        case 400:
            self = .badRequest(error: error)
        case 401:
            self = .unauthorized(error: error)
        case 404:
            self = .notFound(error: error)
        case 422:
            self = .unprocessableEntity(error: error)
        case 500..<600:
            self = .serverError
        default:
            self = .unknown
        }
    }
    
    init(message: String) {
        self = .custom(message: message)
    }
}

extension ApiError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .timeout:
            return "request timeout"
        case .serverError:
            return "server error"
        case .notFound(let error):
            return "not found, error: \(String(describing: error))"
        case .unauthorized(let error):
            return "unauthorized, error: \(String(describing: error))"
        case .badRequest(let error):
            return "bad request, error: \(String(describing: error))"
        case .unprocessableEntity(let error):
            return "unprocessableEntity, error: \(String(describing: error))"
        case .decodingFailed:
            return "decoding failed"
        case .nilData:
            return "nil data"
        case .parametersShouldHaveValue:
            return "parameters should have value"
        case .unknown:
            return "unknown error"
        case .custom(let message):
            return "Error with message: \(message)"
        }
    }
}
