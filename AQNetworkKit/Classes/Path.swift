//
//  Path.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

public enum Path {
    /// url means from a rest api
    case url(String)
    /// bundle means the file is stored in this project
    case bundle(fileName: String, extension: FileExtension)
}
