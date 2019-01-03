//
//  TimeService.swift
//  ChronoSync
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation

public class TimeService {
    fileprivate enum Constant {
        fileprivate static let nanosecondsInMilliseconds: UInt = 1_000_000
        fileprivate static let nanosecondsInMillisecondsOver2: UInt = 500_000
    }

    private let timefunc: (clockid_t) -> __uint64_t

    /**
     - parameter timefunc: a closure that returns the current time in nanoseconds when given a clock type
     */
    public init(_ timefunc: @escaping (clockid_t) -> __uint64_t) {
        self.timefunc = timefunc
    }

    /**
     - returns: the system uptime converted to milliseconds, correctly rounds up or down
     */
    public func uptime() -> UInt {
        let nanoseconds = UInt(timefunc(CLOCK_MONOTONIC_RAW))
        if nanoseconds <= 0 {
            fatalError("Could not execute clock_gettime_nsec_np, errno: \(errno)")
        }

        return (nanoseconds + Constant.nanosecondsInMillisecondsOver2) / Constant.nanosecondsInMilliseconds
    }
}
