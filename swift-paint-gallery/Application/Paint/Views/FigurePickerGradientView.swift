import UIKit

final class FigurePickerGradientView: UIView {
    private(set) var locations: [NSNumber]
    private(set) var startPoint: CGPoint
    private(set) var endPoint: CGPoint
    
    init(locations _locations: [NSNumber] = [], startPoint _startPoint: CGPoint = .zero, endPoint _endPoint: CGPoint = .zero) {
        locations = _locations
        startPoint = _startPoint
        endPoint = _endPoint
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemCyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
