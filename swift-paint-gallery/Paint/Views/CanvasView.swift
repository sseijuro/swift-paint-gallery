//
//  CanvasView.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class CanvasView: UIView {
    weak var delegate: CanvasDelegate?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        let newLayer = CAShapeLayer()
        newLayer.fillColor = UIColor.clear.cgColor
        
        if let color = delegate?.color,
           let width = delegate?.width {
            newLayer.strokeColor = color
            newLayer.lineWidth = width
        }
        
        layer.addSublayer(newLayer)
        delegate?.pushFigure()
        delegate?.pushPointToLastFigure(point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil),
              let layer = layer.sublayers?.last as? CAShapeLayer
        else { return }
        delegate?.pushPointToLastFigure(point)
        delegate?.draw(atLayer: layer)
        setNeedsDisplay()
    }
    
    func setupConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}


