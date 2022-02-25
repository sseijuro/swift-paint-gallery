//
//  DrawDelegate.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

protocol DrawDelegate: AnyObject {
    func draw(atLayer layer: CALayer)
}
