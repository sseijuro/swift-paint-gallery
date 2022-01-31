import UIKit

final class FigurePickerGradientView: UIView {
    init(locations: [NSNumber] = [], startPoint: CGPoint = .zero, endPoint: CGPoint = .zero) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemGray, UIColor.systemGray3]
        gradientLayer.locations = locations
        gradientLayer.endPoint = endPoint
        gradientLayer.startPoint = startPoint
        gradientLayer.frame = bounds
        gradientLayer.type = .axial
        gradientLayer.borderWidth = 1
        layer.insertSublayer(gradientLayer, at: 0)
        backgroundColor = .systemGray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
