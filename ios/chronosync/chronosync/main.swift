//
//  main.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation
import UIKit

private func applicationClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(Application.self) : NSStringFromClass(TestApplication.self)
}

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, applicationClassName(), nil)
