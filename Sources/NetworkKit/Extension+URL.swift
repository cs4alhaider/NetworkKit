//
//  Extension+URL.swift
//  NetworkKit
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import Foundation

public extension URL {
    
    /// Initializing a URL from a `StaticString` which is known at compile time.
    ///
    /// - Disclaimer: This uses a StaticString
    ///
    /// - Parameter string: URL
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }
    
    subscript(_ name: String) -> String? {
        let urlComponents = URLComponents(string: self.absoluteString)
        let queryItems = urlComponents?.queryItems
        return queryItems?[name]
    }
    
    /// Converting regular url into query parameters
    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    /// Adding parameters into a URL
    ///
    /// Example:
    /// ```
    /// let url = "http://mysite3994.com"
    ///
    /// let params = ["name": "Abdullah",
    ///               "github": "cs4alhaider"]
    ///
    /// let urlWithParams = url.addingURLQuery(params) // -> It will return "http://mysite3994.com/?name=Abdullah&github=cs4alhaider"
    /// ```
    ///
    /// - Parameter param: Your parameters to be included in the string url
    /// - Returns: the value, String
    func addingURLQuery(_ params: [String: Any]) -> URL {
        guard var urlComponents = URLComponents(url: self.absoluteURL, resolvingAgainstBaseURL: true) else { return self }
        urlComponents.queryItems = .init(params)
        return urlComponents.url ?? self
    }
}
