//
//  MainAssembly.swift
//  ChronoSync
//
//  Created by Vandermyn, Cody on 11/20/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation

import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppDelegate.self) { (resolver) -> AppDelegate in
            return AppDelegate()
        }.inObjectScope(.container)

        container.register(TimeService.self) { (resolver) -> TimeService in
            return TimeService(clock_gettime_nsec_np)
        }
    }
}
