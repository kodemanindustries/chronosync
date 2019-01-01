//
//  TestMainAssembly.swift
//  TeamBossTests
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation

import Swinject

class TestMainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TestAppDelegate.self) { (resolver) -> TestAppDelegate in
            return TestAppDelegate()
        }.inObjectScope(.container)
    }
}
