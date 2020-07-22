//
//  Extension+Error.swift
//  NetworkKit
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import Foundation

public extension Error {
    
    /// Error code as NSError code
    var code: Int {
        (self as NSError).code
    }
}
