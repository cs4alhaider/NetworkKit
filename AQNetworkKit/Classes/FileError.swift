//
//  FileError.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

public enum FileError: Error {
    case failedToLocateFile(String)
    case failedToLoadFile(String)
    case failedToDecodeFile(String)
}

extension FileError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .failedToLocateFile(let file):
            return #"Failed to locate "\#(file)" file in app bundle."#
        case .failedToLoadFile(let file):
            return #"Failed to load "\#(file)" file in app bundle."#
        case .failedToDecodeFile(let file):
            return #"Failed to decode "\#(file)" file from app bundle."#
        }
    }
}

