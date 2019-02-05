//
//  ForceCast.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation

public func forceCast<T>(_ objectToCast: Any?, _: T.Type, file: String = #file, method: String = #function, line: Int = #line) -> T {
    guard let castedObject = objectToCast as? T else {
        return objectToCast as! T
    }

    return castedObject
}
