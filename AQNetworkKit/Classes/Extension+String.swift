//
//  Extension+String.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import Foundation

public extension String {
    
    subscript(_ name: String) -> String? {
        guard let url = URL(string: self) else { return nil }
        let urlComponents = URLComponents(string: url.absoluteString)
        let queryItems = urlComponents?.queryItems
        return queryItems?[name]
    }
    
    /// Adding parameters into a string URL
    ///
    /// Example:
    /// ```
    /// let url = "http://mysite3994.com"
    ///
    /// let params = ["name": "Abdullah",
    ///               "github": "cs4alhaider"]
    ///
    /// let urlWithParams = url.addingURLQueryParameter(params) // -> It will return "http://mysite3994.com/?name=Abdullah&github=cs4alhaider"
    /// ```
    ///
    /// - Parameter param: Your parameters to be included in the string url
    /// - Returns: the value, String
    func addingURLQuery(_ params: [String: Any]) -> String {
        guard var urlComponents = URLComponents(string: self) else { return self }
        urlComponents.queryItems = .init(params)
        return urlComponents.string ?? self
    }
    
    /// Retrieve the value from url string
    ///
    /// Example:
    /// ```
    /// let url = "http://mysite3994.com?test1=blah&test2=blahblah&errorCode=RB_405"
    /// let errorCode = url.getQueryString(parameter: "errorCode")! // -> It will return "RB_405"
    /// ```
    ///
    /// - Parameter param: param that included in the string url
    /// - Returns: the value, String
    func getQueryString(parameter: String) -> String? {
        self[parameter]
    }
}
