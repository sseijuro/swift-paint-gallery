//
//  CustomButton.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class PGDButton: UIButton {
    var figureType: FigureType?
    
    convenience init(size: CGFloat, figureType: FigureType,
                     color: UIColor = .black, weight: UIImage.SymbolWeight = .thin) {
        self.init(size: size, systemName: figureType.icon, color: color, weight: weight)
        self.figureType = figureType
    }
    
    init(size: CGFloat, systemName: String,
         color: UIColor = .black, weight: UIImage.SymbolWeight = .thin) {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        let config = UIImage.SymbolConfiguration(pointSize: size / 2.25, weight: weight)
        let image = UIImage(systemName: systemName, withConfiguration: config)
        setImage(image?.withTintColor(color, renderingMode: .alwaysOriginal), for: .normal)
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
