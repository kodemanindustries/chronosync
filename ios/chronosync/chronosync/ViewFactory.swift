//
//  ViewFactory.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation
import UIKit

/**
 Initializes a BaseView using a frame of zero
 */
public func createView<T: BaseView>(_ type: T.Type) -> T {
    return T(frame: .zero)
}
