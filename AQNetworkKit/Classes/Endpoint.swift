//
//  Endpoint.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

/// The endpoint interface, any server router should implement this interface to be able to connect
public protocol Endpoint {
    
    // MARK:- Properties
    
    /// The base url for your rest api
    var baseURL: String { get }
    
    /// The last path component to the endpoint. will be appended to the base url in the service
    /// or a bundle url for a local file
    var pathURL: Path { get }
    
    /// The default encoded parameters
    var defaultParameters: [String: Any] { get }
    
    /// The additional encoded parameters to be appended in the defaultParameters
    var parameters: [String: Any]? { get }
    
    /// The default HTTP headers to be appended in the request
    var defaultHeaders: [String: String] { get }
    
    /// The additional HTTP headers to be appended in the defaultHeaders
    var headers: [String: String]? { get }
    
    /// Http method as specified by the server
    var method: HTTPMethod { get }
    
    /// The timeout interval of the request
    var timeoutInterval: TimeInterval { get }
    
    /// Determine if you want to print the response in the consol or not for DEBUG mode
    var isPrintable: Bool { get }
    
    
    // MARK:- Methods
    
    /// Request Data Result from the provided endpoint details
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completion: (Result<Data, Error>) -> Void
    func requestDataResult(completion: @escaping DataResult)
    
    /// Request decoded object result from the provided endpoint details
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completion: (Result<T, Error>) -> Void
    func requestDecodedResult<T: Codable>(completion: @escaping DecodedResult<T>)
    
    /// Request string result from the provided endpoint details
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completion: (Result<String, Error>) -> Void
    func requestStringResult(completion: @escaping StringResult)
}

// Extending the protocol gives the advantage of declaring a function and provide the default implementation for it.
// can be called from any object that conforms to the protocol

// MARK:- Default values
public extension Endpoint {
    
    /// NOTE: you should not override this property
    var url: String {
        switch pathURL {
        case .url(let pathURL):
            return pathURL.starts(with: "http") ? (pathURL) : (baseURL + pathURL)
        case .bundle(let fileName, let fileExtension):
            return "\(fileName).\(fileExtension.value)"
        }
    }
    
    var baseURL: String {
        /// You need to extend `Endpoint` protocol and add a default value for this property
        /// just create a new file name it e.g `EndpointConfig` and add your default values there
        ///
        /// - Example:
        ///```
        /// import DataLayerKit
        ///
        /// extension Endpoint {
        ///     var baseURL: String {
        ///         return "https://jsonplaceholder.typicode.com"
        ///     }
        /// }
        ///```
        fatalError("Your base url need to be configured!, read the above comments for more details and example.")
    }
    
    var defaultHeaders: [String: String] {
        var header: [String: String] = [:]
        var allHeaders = headers ?? [String: String]()
        header["Content-Type"] = "application/json"
        header["Accept"] = "application/json"
        allHeaders += header
        return allHeaders
    }
    
    var defaultParameters: [String: Any] {
        let params: [String: Any] = [:]
        var allParameters = parameters ?? [String: Any]()
        allParameters += params
        return allParameters
    }
    
    var timeoutInterval: TimeInterval {
        return 30
    }
    
    var isPrintable: Bool {
        return true
    }
}

// MARK:- Default Methods
public extension Endpoint {
    
    func requestDataResult(completion: @escaping DataResult) {
        DataService.shared.requestDataResult(endpoint: self, completion: completion)
    }
    
    func requestDecodedResult<T: Codable>(completion: @escaping DecodedResult<T>) {
        DataService.shared.requestDecodedResult(endpoint: self, completion: completion)
    }
    
    func requestStringResult(completion: @escaping StringResult) {
        DataService.shared.requestStringResult(endpoint: self, completion: completion)
    }
}
