//
//  Paint.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

class PaintModel {
    var figureType: FigureType = .CurveLine
    var color: CGColor = UIColor.systemBlue.cgColor
    var width: CGFloat = 3
    var figures = [FigureModel]()
    
    static let colorsList: [UIColor] = [.systemBlue, .systemRed, .systemCyan, .systemGray,
                                 .systemMint, .systemPink, .systemTeal, .systemGreen,
                                 .systemBrown, .systemIndigo, .systemPurple, .systemYellow]
}
