//
//  ViewIdentifiable.swift
//  KICommon
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewIdentifiable {}

extension ViewIdentifiable {
    public func toString() -> String {
        return String(reflecting: self)
    }
}

extension UIView {
    public var testIdentifier: ViewIdentifiable? {
        get { return nil }
        set {
            assert(newValue != nil, "Cannot assign 'nil' as the testIdentifier")
            accessibilityIdentifier = String(reflecting: newValue!)
        }
    }
}
