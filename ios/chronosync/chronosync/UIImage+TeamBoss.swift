//
//  UIImage+TeamBoss.swift
//  TeamBoss
//
//  Created by Vandermyn, Cody on 11/27/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation
import UIKit

private class CustomTeamBossImages {}
private let bundle = Bundle(for: CustomTeamBossImages.self)

/**
 Returns a UIImage and ensures image exists. Crashes otherwise.

 - parameter named: Name of the image to load.
 - parameter in: The bundle the image is located in. Defaults to `nil` (`Bundle.main`)
 - parameter compatibleWith: The trait collection the image is compatible with. Defaults to `UIScreen.main`
 */
public func image(_ named: String, in bundle: Bundle, compatibleWith traitCollection: UITraitCollection? = nil) -> UIImage {
    guard let image = UIImage(named: named, in: bundle, compatibleWith: traitCollection) else {
        fatalError("Could not load '\(named)' image. Is it in the bundle?")
    }
    return image
}

extension UIImage {

}
