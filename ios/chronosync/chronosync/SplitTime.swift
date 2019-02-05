//
//  SplitTime.swift
//  ChronoSync
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation

public typealias Details = String

public struct SplitTime: TimeType {
    public var time: Time
    public var details: Details?
    public let sortNumber: Int

    public var milliseconds: UInt {
        return time.milliseconds
    }

    init(milliseconds: UInt, sortNumber: Int) {
        self.time = Time(milliseconds: milliseconds)
        self.sortNumber = sortNumber
    }

    init(time: Time, sortNumber: Int) {
        self.time = time
        self.sortNumber = sortNumber
    }
}

extension SplitTime: Comparable {
    public static func < (lhs: SplitTime, rhs: SplitTime) -> Bool {
        return lhs.time < rhs.time
    }
}

extension SplitTime: CustomStringConvertible {
    public var description: String {
        return "\(hours):\(minutes):\(seconds).\(milliseconds), \(sortNumber), \(details ?? "")"
    }
}

extension SplitTime: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "SplitTime: \(hours):\(minutes):\(seconds).\(milliseconds), \(sortNumber), \(details ?? "No Details")"
    }
}
