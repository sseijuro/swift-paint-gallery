//
//  GradientView.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class FigurePickerGradientView: UIView {
    init(startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0)) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.insertSublayer(makeGradientLayer(startPoint: startPoint, endPoint: endPoint), at: 0)
        backgroundColor = .systemGray5
    }
    
    func makeGradientLayer(startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.endPoint = endPoint
        gradientLayer.startPoint = startPoint
        gradientLayer.frame = frame
        gradientLayer.borderWidth = 1
        return gradientLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

