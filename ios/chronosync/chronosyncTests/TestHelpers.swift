//
//  TestHelpers.swift
//  ChronoSyncTests
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
    UIApplication.shared.keyWindow?.subviews.forEach { $0.removeFromSuperview() }
    UIApplication.shared.keyWindow?.rootViewController = viewController
}

public func testView(_ view: UIView, size: (width: CGFloat?, height: CGFloat?)? = nil, onBackgroundColor backgroundColor: UIColor = .white) {
    let viewController = UIViewController()
    view.translatesAutoresizingMaskIntoConstraints = false
    viewController.view.backgroundColor = backgroundColor
    viewController.view.addSubview(view)

    NSLayoutConstraint.activate([
        view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
        view.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
    ])

    var constraints: [NSLayoutConstraint] = []
    if let height = size?.height, let width = size?.width {
        constraints.append(view.heightAnchor.constraint(equalToConstant: height))
        constraints.append(view.widthAnchor.constraint(equalToConstant: width))
    } else if let height = size?.height, size?.width == nil { // then fill width
        constraints.append(view.heightAnchor.constraint(equalToConstant: height))
        constraints.append(contentsOf: [
            view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
        ])
    } else if let width = size?.width, size?.height == nil { // then fill height
        constraints.append(view.widthAnchor.constraint(equalToConstant: width))
        constraints.append(contentsOf: [
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
        ])
    } // else let the view size itself

    NSLayoutConstraint.activate(constraints)
    testViewController(viewController)
}
