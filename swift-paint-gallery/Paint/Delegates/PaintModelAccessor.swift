//
//  CanvasPaintModelAccess.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import CoreGraphics

protocol PaintModelAccessor: AnyObject {
    var paintModel: PaintModel { get set }
    var statusBarHeight: CGFloat { get }
    var navBarHeight: CGFloat { get }
}
