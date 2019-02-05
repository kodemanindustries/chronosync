//
//  Application.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation
import UIKit

import Swinject
import SwinjectStoryboard

private protocol ApplicationRoot {
    var strongDelegate: UIApplicationDelegate? { get set }
    var container: Container { get set }
    func createAssembler(forContainer container: Container) -> Assembler
}

class Application: UIApplication, ApplicationRoot {
    fileprivate var strongDelegate: UIApplicationDelegate?
    private var assembler: Assembler!
    fileprivate var container: Container

    override init() {
        container = Container(parent: nil, defaultObjectScope: .graph)

        super.init()

        SwinjectStoryboard.defaultContainer = container
        assembler = createAssembler(forContainer: container)
        let resolver = assembler.resolver
        let appDelegate = resolver.forceResolve(AppDelegate.self)
        strongDelegate = appDelegate
        delegate = strongDelegate
    }

    fileprivate func createAssembler(forContainer container: Container) -> Assembler {
        let assemblies: [Assembly] = [
            MainAssembly(),
        ]

        return Assembler(assemblies, container: container)
    }
}

class TestApplication: UIApplication, ApplicationRoot {
    fileprivate var strongDelegate: UIApplicationDelegate?
    private var assembler: Assembler!
    fileprivate var container: Container

    override init() {
        container = Container(parent: nil, defaultObjectScope: .graph)

        super.init()

        SwinjectStoryboard.defaultContainer = container
        assembler = createAssembler(forContainer: container)
        let resolver = assembler.resolver
        let appDelegate = resolver.forceResolve(TestAppDelegate.self)
        strongDelegate = appDelegate
        delegate = strongDelegate
    }

    fileprivate func createAssembler(forContainer container: Container) -> Assembler {
        let assemblies: [Assembly] = [
            TestMainAssembly(),
        ]

        return Assembler(assemblies, container: container)
    }
}
