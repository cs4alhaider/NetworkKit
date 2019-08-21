//
//  Typealias.swift
//  AQNetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

public typealias DataResult = (Result<Data, Error>) -> Void

public typealias DecodedResult<T: Codable> = (Result<T, Error>) -> Void

public typealias StringResult = (Result<String, Error>) -> Void

