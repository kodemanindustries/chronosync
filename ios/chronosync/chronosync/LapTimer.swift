//
//  LapTimer.swift
//  ChronoSync
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation

public protocol LapTimerType: TimerType {
    var lapTimes: [Time] { get }
    var splits: [SplitTime] { get }
}

extension LapTimerType {
    public var splits: [SplitTime] {
        if lapTimes.count > 1 {
            var splits: [SplitTime] = []
            for i in 0..<lapTimes.count {
                let lapTime = lapTimes[i]
                let nextLapTime = i > 0 ? lapTimes[i - 1] : Time.zero()
                let splitTime = SplitTime(time: lapTime - nextLapTime, sortNumber: i)
                splits.append(splitTime)
            }
            return splits
        }
        else if lapTimes.count == 1 {
            let lapTime = lapTimes[0]
            let splitTime = SplitTime(milliseconds: lapTime.milliseconds, sortNumber: 0)
            return [splitTime]
        }
        else {
            return []
        }
    }
}

/*
 `LapTimer`'s main goal is to produce a sequence of lap times. Being a `TimerType`, it also is able to be paused, resumed, stopped, etc.
 */
public class LapTimer: LapTimerType {
    public private(set) var lapTimes: [Time]

    private var timeService: TimeService

    public init(timeService: TimeService, title: String) {
        self.timeService = timeService
        self.title = title
        self.lapTimes = []

        isRunning = false
        hasStarted = false
        startTime = Time.zero()
        stopTime = Time.zero()
        resumeTime = Time.zero()
        pausedTime = Time.zero()
    }

    public func takeLapTimeNow() {
        precondition(isRunning, "Cannot take a lap time if the LapTimer is not running")
        takeLapTime(withClockTime: timeService.uptime())
    }

    private func time(withClockTime clockTime: UInt) -> Time {
        let currentTime = Time(milliseconds: clockTime)
        let time = currentTime - startTime - pausedTime
        return time
    }

    private func takeLapTime(withClockTime lapTime: UInt) {
        lapTimes.append(time(withClockTime: lapTime))
    }

    private func removeLastLapTime() {
        lapTimes.removeLast()
    }

    private func start(withClockTime startTime: UInt) {
        isRunning = true
        hasStarted = true
        self.startTime = Time(milliseconds: startTime)
    }

    private func stop(withClockTime stopTime: UInt) {
        isRunning = false
        self.stopTime = Time(milliseconds: stopTime)
        takeLapTime(withClockTime: stopTime)
    }

    private func resume(withClockTime resumeTime: UInt) {
        isRunning = true
        self.resumeTime = Time(milliseconds: resumeTime)
        self.pausedTime += self.resumeTime - stopTime
        removeLastLapTime()
    }

    // MARK: - TimerType
    public private(set) var title: String
    public private(set) var identifier = UUID()

    public private(set) var isRunning: Bool
    public private(set) var hasStarted: Bool
    public private(set) var startTime: Time
    public private(set) var stopTime: Time
    public private(set) var resumeTime: Time
    public private(set) var pausedTime: Time

    public var tickingTime: Time {
        if (hasStarted) {
            return time(withClockTime: timeService.uptime())
        }
        else {
            return Time.zero()
        }
    }

    public func startNow() {
        start(withClockTime: timeService.uptime())
    }

    public func stopNow() {
        precondition(isRunning, "Cannot stop a LapTimer that is not running.")
        stop(withClockTime: timeService.uptime())
    }

    public func resumeNow() {
        precondition(!isRunning, "Cannot resume a LapTimer that is already running.")
        resume(withClockTime: timeService.uptime())
    }

    public func reset() {
        isRunning = false
        hasStarted = false

        lapTimes = []

        startTime = Time.zero()
        stopTime = Time.zero()
        resumeTime = Time.zero()
        pausedTime = Time.zero()
    }
}
