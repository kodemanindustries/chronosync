//
//  TimerDisplaySpec.swift
//  ChronoSync
//
//  Created by Vandermyn, Cody on 2/5/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import ChronoSync

class ResolutionedLapTimerSpec: QuickSpec {
    override func spec() {
        var subject: ResolutionedLapTimer!
        var lapTimer: FakeLapTimer!

        describe("second resolution") {
            beforeEach {
                lapTimer = FakeLapTimer()
                subject = ResolutionedLapTimer(lapTimer: lapTimer, resolution: .second)

                lapTimer.stub(.lapTimes).andReturn([
                    Time(milliseconds: 444),
                    Time(milliseconds: 888),
                    Time(milliseconds: 1332),
                    Time(milliseconds: 1776),
                    Time(milliseconds: 2220),
                ])
                lapTimer.stub(.tickingTime).andReturn(Time(milliseconds: 2220))
            }

            it("should adjust the ticking time") {
                expect(subject.tickingTime).to(equal(Time(milliseconds: 2000)))
            }

            it("should adjust the lap times") {
                expect(subject.lapTimes).to(equal([
                    Time(milliseconds: 0),
                    Time(milliseconds: 1000),
                    Time(milliseconds: 1000),
                    Time(milliseconds: 2000),
                    Time(milliseconds: 2000),
                ]))
            }

            it("should adjust the split times") {
                expect(subject.splits).to(equal([
                    SplitTime(milliseconds: 0, sortNumber: 0),
                    SplitTime(milliseconds: 1000, sortNumber: 1),
                    SplitTime(milliseconds: 0, sortNumber: 2),
                    SplitTime(milliseconds: 1000, sortNumber: 3),
                    SplitTime(milliseconds: 0, sortNumber: 4),
                ]))
            }
        }

        describe("tenths resolution") {
            beforeEach {
                lapTimer = FakeLapTimer()
                subject = ResolutionedLapTimer(lapTimer: lapTimer, resolution: .tenths)

                lapTimer.stub(.lapTimes).andReturn([
                    Time(milliseconds: 444),
                    Time(milliseconds: 888),
                    Time(milliseconds: 1332),
                    Time(milliseconds: 1776),
                    Time(milliseconds: 2220),
                ])
                lapTimer.stub(.tickingTime).andReturn(Time(milliseconds: 2220))
            }

            it("should adjust the ticking time") {
                expect(subject.tickingTime).to(equal(Time(milliseconds: 2200)))
            }

            it("should adjust the lap times") {
                expect(subject.lapTimes).to(equal([
                    Time(milliseconds: 400),
                    Time(milliseconds: 900),
                    Time(milliseconds: 1300),
                    Time(milliseconds: 1800),
                    Time(milliseconds: 2200),
                ]))
            }

            it("should adjust the split times") {
                expect(subject.splits).to(equal([
                    SplitTime(milliseconds: 400, sortNumber: 0),
                    SplitTime(milliseconds: 500, sortNumber: 1),
                    SplitTime(milliseconds: 400, sortNumber: 2),
                    SplitTime(milliseconds: 500, sortNumber: 3),
                    SplitTime(milliseconds: 400, sortNumber: 4),
                ]))
            }
        }

        describe("hundredths resolution") {
            beforeEach {
                lapTimer = FakeLapTimer()
                subject = ResolutionedLapTimer(lapTimer: lapTimer, resolution: .hundredths)

                lapTimer.stub(.lapTimes).andReturn([
                    Time(milliseconds: 444),
                    Time(milliseconds: 888),
                    Time(milliseconds: 1332),
                    Time(milliseconds: 1776),
                    Time(milliseconds: 2220),
                ])
                lapTimer.stub(.tickingTime).andReturn(Time(milliseconds: 2220))
            }

            it("should adjust the ticking time") {
                expect(subject.tickingTime).to(equal(Time(milliseconds: 2220)))
            }

            it("should adjust the lap times") {
                expect(subject.lapTimes).to(equal([
                    Time(milliseconds: 440),
                    Time(milliseconds: 890),
                    Time(milliseconds: 1330),
                    Time(milliseconds: 1780),
                    Time(milliseconds: 2220),
                ]))
            }

            it("should adjust the split times") {
                expect(subject.splits).to(equal([
                    SplitTime(milliseconds: 440, sortNumber: 0),
                    SplitTime(milliseconds: 450, sortNumber: 1),
                    SplitTime(milliseconds: 440, sortNumber: 2),
                    SplitTime(milliseconds: 450, sortNumber: 3),
                    SplitTime(milliseconds: 440, sortNumber: 4),
                ]))
            }
        }

        describe("thousandths resolution") {
            beforeEach {
                lapTimer = FakeLapTimer()
                subject = ResolutionedLapTimer(lapTimer: lapTimer, resolution: .thousandths)

                lapTimer.stub(.lapTimes).andReturn([
                    Time(milliseconds: 444),
                    Time(milliseconds: 888),
                    Time(milliseconds: 1332),
                    Time(milliseconds: 1776),
                    Time(milliseconds: 2220),
                ])
                lapTimer.stub(.tickingTime).andReturn(Time(milliseconds: 2222))
            }

            it("should adjust the ticking time") {
                expect(subject.tickingTime).to(equal(Time(milliseconds: 2222)))
            }

            it("should adjust the lap times") {
                expect(subject.lapTimes).to(equal([
                    Time(milliseconds: 444),
                    Time(milliseconds: 888),
                    Time(milliseconds: 1332),
                    Time(milliseconds: 1776),
                    Time(milliseconds: 2220),
                ]))
            }

            it("should adjust the split times") {
                expect(subject.splits).to(equal([
                    SplitTime(milliseconds: 444, sortNumber: 0),
                    SplitTime(milliseconds: 444, sortNumber: 1),
                    SplitTime(milliseconds: 444, sortNumber: 2),
                    SplitTime(milliseconds: 444, sortNumber: 3),
                    SplitTime(milliseconds: 444, sortNumber: 4),
                ]))
            }
        }

    }
}
