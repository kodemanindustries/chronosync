//
//  FakeTimeService.swift
//  ChronoSyncTests
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation
import Spry

@testable import ChronoSync

class FakeTimeService: TimeService, Spryable {
    enum Function: String, StringRepresentable {
        case uptime = "uptime()"
    }

    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    override func uptime() -> UInt {
        return spryify()
    }

    convenience init() {
        let timefunc: (clockid_t) -> __uint64_t = { _ in
            return 1
        }
        self.init(timefunc)
    }
}
