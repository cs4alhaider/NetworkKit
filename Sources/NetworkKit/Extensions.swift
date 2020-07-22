//
//  Extensions.swift
//  NetworkKit
//
//  Created by Abdullah Alhaider on 21/08/2019.
//

import Foundation

// MARK:- Date

public extension Date {
    
    /// Calculating the time between two dates
    ///
    /// - Parameter date: the starting date
    /// - Returns: time since two dates
    func timeSince(_ date: Date) -> TimeInterval {
        let time = Date()
        return time.timeIntervalSince(date)
    }
}

