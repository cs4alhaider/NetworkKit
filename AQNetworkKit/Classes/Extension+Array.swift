//
//  Extension+Array.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import Foundation

/// Convert a dictionary into an array of query items
public extension Array where Element == URLQueryItem {
    init(_ dictionary: [String: Any]) {
        self = dictionary.map({ (key, value) -> Element in
            URLQueryItem(name: key, value: String(describing: value))
        })
    }
}
