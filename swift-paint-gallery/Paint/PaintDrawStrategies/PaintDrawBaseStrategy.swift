//
//  PaintDrawStrategy.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

class PaintDrawBaseStrategy {
    class func draw(atLayer layer: CALayer, points: [CGPoint]) {
        guard let shapeLayer = layer as? CAShapeLayer,
              points.count >= 2 else { return }
        shapeLayer.path = setupPath(withPoints: points).cgPath
    }
    
    class func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        fatalError("This method should be overriden")
    }
}
