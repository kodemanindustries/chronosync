//
//  TestAppDelegate.swift
//  KICommon
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation
import UIKit

/**
 Provides a basic application delegate that we can use for our application under test.
 */
class TestAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
