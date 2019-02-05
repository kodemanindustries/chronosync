//
//  LapTimerSpec.swift
//  ChronoSyncTests
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ChronoSync

class LapTimerSpec: QuickSpec {
    override func spec() {
        describe("LapTimer") {
            var subject: LapTimer!
            var timeService: FakeTimeService!
            var title: String!

            beforeEach {
                title = "TestTimer"
                timeService = FakeTimeService()
                subject = LapTimer(timeService: timeService, title: title)
            }

            it("should be in an empty state") {
                expect(subject.title).to(equal(title))
                expect(subject.identifier).toNot(beNil())
                expect(subject.isRunning).to(beFalse())
                expect(subject.hasStarted).to(beFalse())
                expect(subject.startTime).to(equal(Time.zero()))
                expect(subject.stopTime).to(equal(Time.zero()))
                expect(subject.resumeTime).to(equal(Time.zero()))
                expect(subject.pausedTime).to(equal(Time.zero()))
                expect(subject.tickingTime).to(equal(Time.zero()))
            }

            describe("starting now") {
                beforeEach {
                    timeService.stub(.uptime).andReturn(UInt(1000))
                    subject.startNow()
                }

                it("should have the correct state") {
                    expect(subject.title).to(equal(title))
                    expect(subject.identifier).toNot(beNil())
                    expect(subject.isRunning).to(beTrue())
                    expect(subject.hasStarted).to(beTrue())
                    expect(subject.startTime).to(equal(Time(milliseconds: 1000)))
                    expect(subject.stopTime).to(equal(Time.zero()))
                    expect(subject.resumeTime).to(equal(Time.zero()))
                    expect(subject.pausedTime).to(equal(Time.zero()))
                    expect(subject.lapTimes.count).to(equal(0))
                }
            }

            describe("splits add up to total time") {
                beforeEach {
                    timeService.stub(.uptime).andReturn(UInt(1444))
                    subject.startNow()
                    timeService.stubAgain(.uptime).andReturn(UInt(2888))
                    subject.takeLapTimeNow()
                    timeService.stubAgain(.uptime).andReturn(UInt(4332))
                    subject.takeLapTimeNow()
                    timeService.stubAgain(.uptime).andReturn(UInt(5776))
                    subject.takeLapTimeNow()
                    timeService.stubAgain(.uptime).andReturn(UInt(7220))
                    subject.stopNow()
                }

                it("should have the correct lap times") {
                    expect(subject.lapTimes).to(equal([
                        Time(milliseconds: 1444),
                        Time(milliseconds: 2888),
                        Time(milliseconds: 4332),
                        Time(milliseconds: 5776),
                    ]))
                }

                it("should have the correct stop time") {
                    expect(subject.stopTime).to(equal(Time(milliseconds: 7220)))
                }

                it("should have the correct ticking time") {
                    expect(subject.tickingTime).to(equal(Time(milliseconds: 5776)))
                }
            }

            describe("take lap time now") {
                context("when the timer is running") {
                    beforeEach {
                        timeService.stub(.uptime).andReturn(UInt(1000))
                        subject.startNow()
                        timeService.stubAgain(.uptime).andReturn(UInt(1100))
                        subject.takeLapTimeNow()
                        timeService.stubAgain(.uptime).andReturn(UInt(1250))
                        subject.takeLapTimeNow()
                    }

                    it("should have the correct lap times") {
                        expect(subject.lapTimes).to(equal([
                            Time(milliseconds: 100),
                            Time(milliseconds: 250),
                        ]))
                    }

                    it("should have the correct state") {
                        expect(subject.title).to(equal(title))
                        expect(subject.identifier).toNot(beNil())
                        expect(subject.isRunning).to(beTrue())
                        expect(subject.hasStarted).to(beTrue())
                        expect(subject.startTime).to(equal(Time(milliseconds: 1000)))
                        expect(subject.stopTime).to(equal(Time.zero()))
                        expect(subject.resumeTime).to(equal(Time.zero()))
                        expect(subject.pausedTime).to(equal(Time.zero()))
                        expect(subject.lapTimes.count).to(equal(2))
                        expect(subject.tickingTime).to(equal(Time(milliseconds: 250)))
                    }
                }

                context("when the timer is NOT running") {
                    it("should assert the precondition") {
                        expect {
                            subject.takeLapTimeNow()
                        }
                        .to(throwAssertion())
                    }
                }
            }

            describe("stop now") {
                context("when the timer is running") {
                    beforeEach {
                        timeService.stub(.uptime).andReturn(UInt(1000))
                        subject.startNow()
                        timeService.stubAgain(.uptime).andReturn(UInt(1240))
                        subject.stopNow()
                    }

                    it("should have the correct state") {
                        expect(subject.title).to(equal(title))
                        expect(subject.identifier).toNot(beNil())
                        expect(subject.isRunning).to(beFalse())
                        expect(subject.hasStarted).to(beTrue())
                        expect(subject.startTime).to(equal(Time(milliseconds: 1000)))
                        expect(subject.stopTime).to(equal(Time(milliseconds: 1240)))
                        expect(subject.resumeTime).to(equal(Time.zero()))
                        expect(subject.pausedTime).to(equal(Time.zero()))
                        expect(subject.lapTimes.count).to(equal(1))
                        expect(subject.tickingTime).to(equal(Time(milliseconds: 240)))
                    }
                }

                context("when the timer is NOT running") {
                    it("should assert the precondition") {
                        expect {
                            subject.stopNow()
                        }
                        .to(throwAssertion())
                    }
                }
            }

            describe("reset") {
                beforeEach {
                    timeService.stub(.uptime).andReturn(UInt(1000))
                    subject.startNow()
                    timeService.stubAgain(.uptime).andReturn(UInt(1100))
                    subject.takeLapTimeNow()
                    timeService.stubAgain(.uptime).andReturn(UInt(1250))
                    subject.takeLapTimeNow()
                    timeService.stubAgain(.uptime).andReturn(UInt(1300))
                    subject.stopNow()
                    subject.reset()
                }

                it("should have the correct state") {
                    expect(subject.title).to(equal(title))
                    expect(subject.identifier).toNot(beNil())
                    expect(subject.isRunning).to(beFalse())
                    expect(subject.hasStarted).to(beFalse())
                    expect(subject.startTime).to(equal(Time.zero()))
                    expect(subject.stopTime).to(equal(Time.zero()))
                    expect(subject.resumeTime).to(equal(Time.zero()))
                    expect(subject.pausedTime).to(equal(Time.zero()))
                    expect(subject.lapTimes.count).to(equal(0))
                }
            }

            describe("resume now") {
                context("when the timer is running") {
                    it("should assert the precondition") {
                        expect {
                            subject.resumeNow()
                        }
                        .to(throwAssertion())
                    }
                }

                context("when the timer is NOT running") {
                    beforeEach {
                        timeService.stub(.uptime).andReturn(UInt(1000))
                        subject.startNow()
                        timeService.stubAgain(.uptime).andReturn(UInt(1240))
                        subject.stopNow()
                        timeService.stubAgain(.uptime).andReturn(UInt(1540))
                        subject.resumeNow()
                    }

                    it("should have the correct state") {
                        expect(subject.title).to(equal(title))
                        expect(subject.identifier).toNot(beNil())
                        expect(subject.isRunning).to(beTrue())
                        expect(subject.hasStarted).to(beTrue())
                        expect(subject.startTime).to(equal(Time(milliseconds: 1000)))
                        expect(subject.stopTime).to(equal(Time(milliseconds: 1240)))
                        expect(subject.resumeTime).to(equal(Time(milliseconds: 1540)))
                        expect(subject.pausedTime).to(equal(Time(milliseconds: 300)))
                        expect(subject.lapTimes.count).to(equal(0))
                        expect(subject.tickingTime).to(equal(Time(milliseconds: 240)))
                    }
                }
            }
        }
    }
}
