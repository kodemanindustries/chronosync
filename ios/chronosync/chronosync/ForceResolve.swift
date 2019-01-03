//
//  Resolver+TeamBoss.swift
//  KICommon
//
//  Created by Cody Vandermyn on 11/11/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import Foundation

import Swinject

extension Resolver {
    public func forceResolve<T>(_: T.Type, name: String? = nil) -> T {
        return forceCast(self.resolve(T.self, name: name), T.self)
    }
}
