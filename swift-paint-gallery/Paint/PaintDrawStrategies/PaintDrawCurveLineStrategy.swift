//
//  PaintDrawCurveLineStrategy.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class PaintDrawCurveLineStrategy: PaintDrawBaseStrategy {
    override static func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: points[0])
        points.forEach { (point) in
            path.addLine(to: point)
        }
        return path
    }
}
