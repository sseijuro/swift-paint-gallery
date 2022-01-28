import UIKit

class PaintDrawStrategy {
    class func draw(atLayer layer: CALayer, points: [CGPoint]) {
        guard let shapeLayer = layer as? CAShapeLayer,
              points.count >= 2 else { return }
        shapeLayer.path = setupPath(withPoints: points).cgPath
    }
    
    class func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        fatalError("This method should be overriden")
    }
}

final class PaintDrawCurveLineStrategy: PaintDrawStrategy {
    override static func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: points[0])
        points.forEach { (point) in
            path.addLine(to: point)
        }
        return path
    }
}

final class PaintDrawLineStrategy: PaintDrawStrategy {
    override static func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: points[0])
        path.addLine(to: points[points.count - 1])
        return path
    }
}

final class PaintDrawRectangleStrategy: PaintDrawStrategy {
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

final class PaintDrawTriangleStrategy: PaintDrawStrategy {
    override static func setupPath(withPoints points: [CGPoint]) -> UIBezierPath {
        let first = points[0]
        let last = points[points.count - 1]
        let path = UIBezierPath()
        
        path.move(to: first)
        path.addLine(to: last)
        path.addLine(to: CGPoint(x: first.x, y: last.y))
        path.addLine(to: first)
        
        return path
    }
}

final class PaintDrawCircleStrategy: PaintDrawStrategy {
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
