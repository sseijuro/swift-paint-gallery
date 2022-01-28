import UIKit

struct PaintModel {
    var figureType: FigureType = .CurveLine
    var color: CGColor = UIColor.systemRed.cgColor
    var width: CGFloat = 3
    var figures = [FigureModel]()
    
    static let colorsList: [UIColor] = [.systemBlue, .systemRed, .systemCyan, .systemGray,
                                 .systemMint, .systemPink, .systemTeal, .systemGreen,
                                 .systemBrown, .systemIndigo, .systemPurple, .systemYellow]
}
