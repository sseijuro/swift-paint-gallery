//
//  PaintDrawLineStrategy.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class PaintDrawLineStrategy: PaintDrawBaseStrategy {
    override static func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: points[0])
        path.addLine(to: points[points.count - 1])
        return path
    }
}
