import UIKit

final class PaintView: UIView {
    private(set) lazy var canvasView = CanvasView()
    private(set) lazy var colorPickerView = ColorPickerView()
    private(set) lazy var figurePickerView = FigurePickerView()
    private(set) lazy var topRightMenuView = TopRightMenuView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(canvasView)
        addSubview(colorPickerView)
        addSubview(topRightMenuView)
        addSubview(figurePickerView)
        addSubview(figurePickerView.leftGradient)
        addSubview(figurePickerView.rightGradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaintView {
    func setupConstraints() {
        canvasView.setupConstraints(self)
        colorPickerView.setupConstraints(self)
        figurePickerView.setupConstraints(self)
        topRightMenuView.setupConstraints(self)
    }
}
