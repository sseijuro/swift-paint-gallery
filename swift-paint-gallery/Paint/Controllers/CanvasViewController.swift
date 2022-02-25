//
//  CanvasViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class CanvasViewController: UIViewController {
    weak var accessor: PaintModelAccessor?
    
    private var canvasView: CanvasView? {
        view as? CanvasView
    }
    
    override func loadView() {
        view = CanvasView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView?.delegate = self
    }
    
    func setupConstraints(_ view: UIView) {
        canvasView?.setupConstraints(view)
    }
    
    func drawByConcreteStrategy(atLayer layer: CALayer, points: [CGPoint]) {
        guard let paintModel = accessor?.paintModel,
              let lastFigure = paintModel.figures.last else { return }
        switch lastFigure.figureType {
            case .CurveLine:
                PaintDrawCurveLineStrategy.draw(atLayer: layer, points: points)
            case .Line:
                PaintDrawLineStrategy.draw(atLayer: layer, points: points)
            case .Rectangle:
                PaintDrawRectangleStrategy.draw(atLayer: layer, points: points)
            case .Triangle:
                PaintDrawTriangleStrategy.draw(atLayer: layer, points: points)
            case .Circle:
                PaintDrawCircleStrategy.draw(atLayer: layer, points: points)
        }
    }
    
}

extension CanvasViewController: CanvasDelegate {
    var color: CGColor {
        accessor?.paintModel.color ?? UIColor.systemBlue.cgColor
    }

    var width: CGFloat {
        accessor?.paintModel.width ?? 3.0
    }

    func pushFigure() {
        guard let accessor = accessor else { return }
        let newFigure = FigureModel(figureType: accessor.paintModel.figureType)
        if accessor.paintModel.figures.count == 0 {
            accessor.paintModel.figures.append(newFigure)
            return
        }
        accessor.paintModel.figures[0] = newFigure
    }

    func pushPointToLastFigure(_ point: CGPoint) {
        guard let accessor = accessor else { return }

        accessor.paintModel.figures[accessor.paintModel.figures.count - 1].points
            .append(CGPoint(x: point.x, y: point.y - accessor.statusBarHeight - accessor.navBarHeight))
    }

    func draw(atLayer layer: CALayer) {
        guard let figure = accessor?.paintModel.figures.last else { return }
        drawByConcreteStrategy(atLayer: layer, points: figure.points)
    }

}
