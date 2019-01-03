//
//  SplitTime.swift
//  ChronoSyncTests
//
//  Created by Vandermyn, Cody on 1/2/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import Foundation

public typealias Details = String

public struct SplitTime: TimeType {
    public var details: Details?
    public let sortNumber: Int

    // MARK: - TimeType
    public let milliseconds: UInt
    init(milliseconds: UInt, sortNumber: Int) {
        self.milliseconds = milliseconds
        self.sortNumber = sortNumber
    }

    public init(time: Time, sortNumber: Int) {
        self.init(milliseconds: time.milliseconds, sortNumber: sortNumber)
    }
}

extension SplitTime: Equatable {}

extension SplitTime: Comparable {
    public static func < (lhs: SplitTime, rhs: SplitTime) -> Bool {
        return lhs.milliseconds < rhs.milliseconds
    }
}
