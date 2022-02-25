//
//  PaintDrawCircleStrategy.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class PaintDrawCircleStrategy: PaintDrawBaseStrategy {
    override static func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        let first = points[0]
        let last = points[points.count - 1]
        return UIBezierPath(arcCenter: first,
                            radius: CGFloat(sqrt(pow(last.x - first.x, 2) + pow(last.y - first.y, 2))),
                            startAngle: CGFloat(0),
                            endAngle: CGFloat(Double.pi * 2),
                            clockwise: true)
    }
}
