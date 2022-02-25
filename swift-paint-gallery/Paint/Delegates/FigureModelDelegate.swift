//
//  FigureModelDelegate.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import CoreGraphics

protocol FigureModelDelegate: AnyObject {
    func pushFigure()
    func pushPointToLastFigure(_ point: CGPoint)
}
