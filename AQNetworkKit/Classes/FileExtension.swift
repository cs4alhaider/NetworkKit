//
//  FileExtension.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

public enum FileExtension {
    /// `".json"`
    case json
    /// `".txt"`
    case txt
    
    var value: String {
        return String(describing: self)
    }
}
