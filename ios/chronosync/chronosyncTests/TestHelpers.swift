//
//  TestHelpers.swift
//  KICommon
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation
import UIKit

import Nimble
import Quick

@testable import ChronoSync

public func testViewController(_ viewController: UIViewController) {
    UIApplication.shared.keyWindow?.layer.speed = 100
    for view in (UIApplication.shared.keyWindow?.subviews)! {
        view.removeFromSuperview()
    }
    UIApplication.shared.keyWindow?.rootViewController = viewController
}

public func testView(_ view: UIView, size:(width: CGFloat?, height: CGFloat?)? = nil) {
    let viewController = UIViewController()
    view.translatesAutoresizingMaskIntoConstraints = false
    viewController.view.addSubview(view)
    let centerX = NSLayoutConstraint(item: viewController.view, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
    let centerY = NSLayoutConstraint(item: viewController.view, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
    viewController.view.addConstraints([centerX, centerY])

    if let height = size?.height, let width = size?.width {
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: height)
        let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: width)

        let vConstraints = [heightConstraint]
        let hConstraints = [widthConstraint]

        view.addConstraints(vConstraints)
        view.addConstraints(hConstraints)
    }
    else if let height = size?.height, size?.width == nil { // then fill width
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: height)

        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": view])

        view.addConstraint(heightConstraint)
        viewController.view.addConstraints(hConstraints)
    }
    else if let width = size?.width, size?.height == nil { // then fill height
        let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: width)

        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": view])

        view.addConstraint(widthConstraint)
        viewController.view.addConstraints(hConstraints)
    }
    else { // then fill width and height
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": view])
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": view])

        viewController.view.addConstraints(vConstraints)
        viewController.view.addConstraints(hConstraints)
    }
    testViewController(viewController)
}
