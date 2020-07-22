//
//  Extension+Collection.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import Foundation

public extension Collection where Element == URLQueryItem {
    
    /// Directly access the values by going over the query item key
    subscript(_ name: String) -> String? {
        first(where: { $0.name == name })?.value
    }
}
