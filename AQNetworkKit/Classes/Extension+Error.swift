//
//  Extension+Error.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import Foundation

public extension Error {
    
    var code: Int {
        (self as NSError).code
    }
}
