//
//  ResolutionedLapTimer.swift
//  ChronoSync
//
//  Created by Vandermyn, Cody on 2/5/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation

public class ResolutionedLapTimer: LapTimerType {
    public enum Resolution {
        case second
        case tenths
        case hundredths
        case thousandths
    }

    private let lapTimer: LapTimer
    public var resolution: Resolution

    public var lapTimes: [Time] {
        return adjustedLapTimes()
    }

    public var title: String {
        return lapTimer.title
    }

    public var identifier: UUID {
        return lapTimer.identifier
    }

    public var isRunning: Bool {
        return lapTimer.isRunning
    }

    public var hasStarted: Bool {
        return lapTimer.hasStarted
    }

    public var startTime: Time {
        return lapTimer.startTime
    }

    public var stopTime: Time {
        return lapTimer.stopTime
    }

    public var resumeTime: Time {
        return lapTimer.resumeTime
    }

    public var pausedTime: Time {
        return lapTimer.pausedTime
    }

    public var tickingTime: Time {
        return adjustedTickingTime()
    }

    public init(lapTimer: LapTimer, resolution: Resolution) {
        self.lapTimer = lapTimer
        self.resolution = resolution
    }

    public func startNow() {
        lapTimer.startNow()
    }

    public func stopNow() {
        lapTimer.stopNow()
    }

    public func resumeNow() {
        lapTimer.resumeNow()
    }

    public func reset() {
        lapTimer.reset()
    }

    private func adjustedLapTimes() -> [Time] {
        return lapTimer.lapTimes.map { (time) -> Time in
            return rounded(time: time)
        }
    }

    private func adjustedTickingTime() -> Time {
        return rounded(time: lapTimer.tickingTime)
    }

    private func rounded(time: Time) -> Time {
        switch resolution {
        case .second:
            return Time(milliseconds: UInt(round(Double(time.milliseconds) / 1000) * 1000))
        case .tenths:
            return Time(milliseconds: UInt(round(Double(time.milliseconds) / 100) * 100))
        case .hundredths:
            return Time(milliseconds: UInt(round(Double(time.milliseconds) / 10) * 10))
        case .thousandths:
            return time
        }
    }
}
