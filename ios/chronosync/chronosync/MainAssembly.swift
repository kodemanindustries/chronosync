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

        container.register(LapTimer.self) { (resolver) -> LapTimer in
            let timeService = resolver.forceResolve(TimeService.self)
            return LapTimer(timeService: timeService, title: "Laps")
        }

        container.register(ResolutionedLapTimer.self) { (resolver) -> ResolutionedLapTimer in
            let lapTimer = resolver.forceResolve(LapTimer.self)
            return ResolutionedLapTimer(lapTimer: lapTimer, resolution: .hundredths)
        }

        container.storyboardInitCompleted(ViewController.self) { (resolver, controller) in
            let timer = resolver.forceResolve(ResolutionedLapTimer.self)
            controller.inject(timer: timer)
        }
    }
}
