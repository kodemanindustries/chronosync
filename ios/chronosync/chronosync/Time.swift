//
//  Time.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation

private enum Constant {
    fileprivate static let millisecondsInHundredths: UInt = 10
    fileprivate static let millisecondsInTenths: UInt = 100
    fileprivate static let millisecondsInSeconds: UInt = 1000
    fileprivate static let secondsInMinutes: UInt = 60
    fileprivate static let minutesInHours: UInt = 60
}

public protocol TimeType {
    static func zero() -> Time

    var hours: UInt { get }
    var minutes: UInt { get }
    var seconds: UInt { get }
    var milliseconds: UInt { get }
}

extension TimeType {
    public var hours: UInt {
        return minutes / Constant.minutesInHours
    }

    public var minutes: UInt {
        return seconds / Constant.secondsInMinutes
    }

    public var seconds: UInt {
        return milliseconds / Constant.millisecondsInSeconds
    }

    public var tenths: UInt {
        return milliseconds / Constant.millisecondsInTenths
    }

    public var hundredths: UInt {
        return milliseconds / Constant.millisecondsInHundredths
    }

    public static func zero() -> Time {
        return Time(milliseconds: 0)
    }
}

public struct Time: TimeType {
    public let milliseconds: UInt 
    public init(milliseconds: UInt) {
        self.milliseconds = milliseconds
    }
}

extension Time: Comparable {
    public static func < (lhs: Time, rhs: Time) -> Bool {
        return lhs.milliseconds < rhs.milliseconds
    }
}

extension Time: CustomStringConvertible {
    public var description: String {
        return "\(hours):\(minutes):\(seconds).\(milliseconds)"
    }
}

extension Time: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Time: \(hours):\(minutes):\(seconds).\(milliseconds)"
    }
}

extension Time {
    public static func + (lhs: Time, rhs: Time) -> Time {
        let result = lhs.milliseconds + rhs.milliseconds
        precondition(result < UInt.max, "Time Overflow! (\((lhs, rhs)))")
        return Time(milliseconds: result)
    }

    public static func - (lhs: Time, rhs: Time) -> Time {
        precondition(lhs.milliseconds >= rhs.milliseconds, "Time values can only be positive so you must subtract the smaller Time from the larger Time. (\((lhs, rhs)))")
        return Time(milliseconds: lhs.milliseconds - rhs.milliseconds)
    }

    public static func += (lhs: inout Time, rhs: Time) {
        let result = lhs.milliseconds + rhs.milliseconds
        precondition(result < UInt.max, "Time Overflow! (\((lhs, rhs)))")
        lhs = Time(milliseconds: result)
    }
}
