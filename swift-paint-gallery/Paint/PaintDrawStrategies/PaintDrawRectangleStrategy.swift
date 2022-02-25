//
//  PaintDrawRectangleStrategy.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class PaintDrawRectangleStrategy: PaintDrawBaseStrategy {
    override static func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        let first = points[0]
        let last = points[points.count - 1]
        let path = UIBezierPath()
        
        path.move(to: first)
        path.addLine(to: CGPoint(x: first.x, y: last.y))
        path.addLine(to: last)
        path.addLine(to: CGPoint(x: last.x, y: first.y))
        path.addLine(to: first)
        
        return path
    }
}
