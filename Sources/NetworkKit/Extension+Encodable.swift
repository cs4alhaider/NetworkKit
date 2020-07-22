//
//  Extension+Encodable.swift
//  NetworkKit
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import Foundation

public extension Encodable {
    
    /// Converting Encodable object to postable [String: Any]
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let data = try? encoder.encode(self),
            let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json = object as? [String: Any] else { return [:] }
        return json
    }
    
    /// Converting Encodable object to postable array of [String: Any]
    func toDictionaryArray(_ encoder: JSONEncoder = JSONEncoder()) -> [[String: Any]] {
        guard let data = try? encoder.encode(self),
            let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonArray = object as? [[String: Any]] else { return [[:]] }
        return jsonArray
    }
}
