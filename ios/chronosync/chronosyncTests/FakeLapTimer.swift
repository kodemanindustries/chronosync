//
//  FakeLapTimer.swift
//  ChronoSyncTests
//
//  Created by Vandermyn, Cody on 2/5/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation
import Spry

@testable import ChronoSync

class FakeLapTimer: LapTimer, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case lapTimes = "lapTimes"
        case tickingTime = "tickingTime"
    }

    override var lapTimes: [Time] {
        return stubbedValue()
    }

    override var tickingTime: Time {
        return stubbedValue()
    }

    convenience init() {
        self.init(timeService: FakeTimeService(), title: "FakeLapTimer")
    }
}
