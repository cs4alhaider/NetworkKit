//
//  DataService.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

public final class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    // MARK:- public methods
    
    /// Request Data Result from the provided endpoint details
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completion: (Result<Data, Error>) -> Void
    public func request(endpoint: Endpoint, completion: @escaping DataResult) {
        dataResponse(endpoint: endpoint, completion: completion)
    }
    
    /// Request decoded object result from the provided endpoint details
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completion: (Result<T, Error>) -> Void
    public func request<T: Decodable>(endpoint: Endpoint, completion: @escaping DecodedResult<T>) {
        decodedResponse(endpoint: endpoint, completion: completion)
    }
    
    
    /// Request string result from the provided endpoint details
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completion: (Result<String, Error>) -> Void
    public func request(endpoint: Endpoint, completion: @escaping StringResult) {
        stringResponse(endpoint: endpoint, completion: completion)
    }
}

// -----------------------
// MARK:- private methods
// -----------------------

private extension NetworkService {
    
    /// The main method to hit the api
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - completion: (Result<T, Error>) -> Void
    private func dataResponse(endpoint: Endpoint, completion: @escaping DataResult) {
        switch endpoint.pathURL {
        case .url:
            fromRestApi(endpoint: endpoint, completion: completion)
        case .bundle:
            fromLocalJSONFile(endpoint: endpoint, completion: completion)
        }
    }
    
    private func fromRestApi(endpoint: Endpoint, completion: @escaping DataResult) {
        
        #if DEBUG
        let date = Date()
        if endpoint.isPrintable {
            print("""
                =================================================================
                ⬆️ Sending \(endpoint.method.name) Request to API '\(endpoint.url)'
                📝 Request headers:\n\(endpoint.defaultHeaders.isEmpty ? "nil" : endpoint.defaultHeaders.json)
                📝 Request Body:\n\(endpoint.defaultParameters.isEmpty ? "nil" : endpoint.defaultParameters.json)
                
                """)
        }
        #endif
        
        let session = URLSession(configuration: endpoint.session)
        
        // starting the request task asynchronous
        let task = session.dataTask(with: urlRequest(endpoint: endpoint)) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            
            // check for a response objcet
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError(message: "HTTP URL Response Error", error: nil)))
                }
                return
            }
            
            // check for a successful status code
            guard Array(200..<300).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError(statusCode: response.statusCode, error: ApiError(message: "Error: status code is \(response.statusCode)", error: nil))))
                }
                return
            }
            
            // check for response body
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.nilData(error: nil)))
                }
                return
            }
            
            #if DEBUG
            if endpoint.isPrintable {
                print("""
                    =================================================================
                    ✅ Response: \(endpoint.method.name) '\(response.url?.absoluteString ?? "<?>")'
                    🧾 Status Code: \(response.statusCode),
                    💾 Data: \(data),
                    ⏳ Time: \(Date().timeSince(date))
                    ⬇️ Response headers:\n\(response.allHeaderFields.json)
                    ⬇️ Response Body:\n\(String(data: data, encoding: String.Encoding.utf8) ?? "")
                    
                    """)
            }
            #endif
            
            completion(.success(data))
            
        }
        
        task.resume()
    }
    
    private func fromLocalJSONFile(endpoint: Endpoint, completion: @escaping DataResult) {
        #if DEBUG
        let date = Date()
        if endpoint.isPrintable {
            print("""
                =================================================================
                🗃 Requesting '\(endpoint.url)' file...
                
                """)
        }
        #endif
        
        let file = endpoint.url
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            completion(.failure(FileError.failedToLocateFile(file)))
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(FileError.failedToLoadFile(file)))
            fatalError()
        }
        
        #if DEBUG
        if endpoint.isPrintable {
            print("""
                =================================================================
                ✅ '\(endpoint.url)' has arrived!:
                💾 \(data),
                ⏳ Time: \(Date().timeSince(date))
                📁 File content:\n\(String(data: data, encoding: String.Encoding.utf8) ?? "")
                
                """)
        }
        #endif
        completion(.success(data))
    }
}


// MARK:- String Response

private extension NetworkService {
    
    private func stringResponse(endpoint: Endpoint, completion: @escaping StringResult) {
        dataResponse(endpoint: endpoint) { (result) in
            switch result {
            case .success(let data):
                guard let string = String(data: data, encoding: String.Encoding.utf8) else {
                    return
                }
                completion(.success(string))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


// MARK:- Decoded Response

private extension NetworkService {
    
    private func decodedResponse<T: Codable>(endpoint: Endpoint, completion: @escaping DecodedResult<T>) {
        dataResponse(endpoint: endpoint) { (result) in
            switch result {
            case .success(let data):
                self.decodeObject(from: data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decodeObject<T: Codable>(from data: Data, completion: @escaping DecodedResult<T>) {
        
        // check if requiring empty response
        guard T.self != Empty.self else {
            DispatchQueue.main.async {
                completion(.success(Empty() as! T))
            }
            return
        }
        
        // try to parse response body into object
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(object))
            }
        } catch let error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}


private extension NetworkService {
    
    // MARK:- Build the url request
    
    /// url request builder
    ///
    /// - Parameter endpoint: Endpoint
    /// - Returns: URLRequest
    private func urlRequest(endpoint: Endpoint) -> URLRequest {
        var request: URLRequest!
        if endpoint.method == .get {
            request = URLRequest(url: urlWith(url: endpoint.url, parameters: endpoint.defaultParameters))
        } else {
            request = URLRequest(url: urlWith(url: endpoint.url))
            request.httpBody = endpoint.defaultParameters.jsonData()
        }
        request.httpMethod = endpoint.method.name
        request.allHTTPHeaderFields = endpoint.defaultHeaders
        request.httpShouldHandleCookies = endpoint.httpShouldHandleCookies
        request.timeoutInterval = endpoint.timeoutInterval
        return request
    }
}


private extension NetworkService {
    
    // MARK:- Append the parameters with the URL
    
    private func urlWith(url: String, parameters: [String: Any]? = nil) -> URL {
        // make sure the base url is valid
        guard let baseUrl = URL(string: url) else {
            fatalError("The BASE URL provided is not a valid url")
        }
        
        if let parameters = parameters {
            // Adding the url query
            return baseUrl.addingURLQuery(parameters)
        } else {
            return baseUrl
        }
    }
}
