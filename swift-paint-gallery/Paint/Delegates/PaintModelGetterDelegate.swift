//
//  PaintModelGetterDelegate.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

protocol PaintModelGetterDelegate: AnyObject {
    var color: CGColor { get }
    var width: CGFloat { get }
}
