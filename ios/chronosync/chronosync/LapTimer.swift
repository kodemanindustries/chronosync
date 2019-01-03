//
//  LapTimer.swift
//  ChronoSync
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation

/*
 LapTimer will produce arrays of lap `Time`s and `SplitTime`s like:
    -- 0.00
    0 1.01 (split)
    0 1.01 (lap)
    1 0.09 (split)
    1 1.10 (lap)
    2 0.35 (split)
    2 1.45 (lap)
    3 1.68 (split)
    3 3.13 (lap)
    4 1.19 (split)
    4 4.32 (lap)
    5 1.66 (split)
    5 5.98 (lap)
 */
public class LapTimer: TimerType {
    public private(set) var lapTimes: [Time]

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

    private func start(withClockTime startTime: UInt) {
        isRunning = true
        hasStarted = true
        self.startTime = Time(milliseconds: startTime)
    }

    private func stop(withClockTime stopTime: UInt) {
        isRunning = false
        self.stopTime = Time(milliseconds: stopTime)
    }

    private func resume(withClockTime resumeTime: UInt) {
        isRunning = true
        self.resumeTime = Time(milliseconds: resumeTime)
        self.pausedTime += self.resumeTime - stopTime
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
