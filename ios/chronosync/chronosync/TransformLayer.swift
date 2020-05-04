//
//  TransformLayer.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 3/24/20.
//  Copyright © 2020 Kodeman Industries. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore

/// `CATransformLayer` opts its view out of drawing since it is only used as a container.
///
/// Interface Builder sets some properties on this layer that aren’t supported. This subclass overrides and no-ops those properties to suppress lots of warning log messages.
public final class TransformLayer: CATransformLayer {
    public override var isOpaque: Bool {
        set {
            // Do nothing
        }

        get {
            return super.isOpaque
        }
    }

    public override var backgroundColor: CGColor? {
        set {
            // Do nothing
        }

        get {
            return super.backgroundColor
        }
    }

    public override var masksToBounds: Bool {
        set {
            // Do nothing
        }

        get {
            return super.masksToBounds
        }
    }

    public override var contentsScale: CGFloat {
        set {
            // Do nothing
        }

        get {
            return super.contentsScale
        }
    }

    public override var rasterizationScale: CGFloat {
        set {
            // Do nothing
        }

        get {
            return super.rasterizationScale
        }
    }

    public override var contentsGravity: CALayerContentsGravity {
        set {
            // Do nothing
        }

        get {
            return super.contentsGravity
        }
    }
}
