//
//  FigureType.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import Foundation

@objc(FigureType)
enum FigureType: Int, CaseIterable {
    case CurveLine = 0
    case Line = 1
    case Rectangle = 2
    case Triangle = 3
    case Circle = 4
    
    var icon: String {
        switch self {
            case .CurveLine:
                return "alternatingcurrent"
            case .Line:
                return "line.diagonal"
            case .Rectangle:
                return "rectangle"
            case .Triangle:
                return "triangle"
            case .Circle:
                return "circle"
        }
    }
    
}
