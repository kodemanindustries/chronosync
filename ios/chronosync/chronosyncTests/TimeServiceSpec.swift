//
//  TimeServiceSpec.swift
//  ChronoSyncTests
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ChronoSync

class TimeServiceSpec: QuickSpec {
    override func spec() {
        describe("TimeService") {
            var returnVal: __uint64_t! // in nanoseconds
            let timefunc: ((clockid_t) -> __uint64_t) = { _ in
                return returnVal
            }

            it("should round the time to the correct milliseconds") {
                returnVal = 000_001
                expect(TimeService(timefunc).uptime()).to(equal(0))

                returnVal = 499_999
                expect(TimeService(timefunc).uptime()).to(equal(0))

                returnVal = 500_000
                expect(TimeService(timefunc).uptime()).to(equal(1))

                returnVal = 1_000_000
                expect(TimeService(timefunc).uptime()).to(equal(1))

                returnVal = 1_000_001
                expect(TimeService(timefunc).uptime()).to(equal(1))

                returnVal = 1_499_999
                expect(TimeService(timefunc).uptime()).to(equal(1))

                returnVal = 1_500_000
                expect(TimeService(timefunc).uptime()).to(equal(2))

                returnVal = 1_999_999
                expect(TimeService(timefunc).uptime()).to(equal(2))

                returnVal = 2_000_000
                expect(TimeService(timefunc).uptime()).to(equal(2))

                returnVal = 112_000_000
                expect(TimeService(timefunc).uptime()).to(equal(112))
            }

            it("should throw an exception when zero") {
                returnVal = 0
                expect {
                    _ = TimeService(timefunc).uptime()
                }
                .to(throwAssertion())
            }
        }
    }
}
