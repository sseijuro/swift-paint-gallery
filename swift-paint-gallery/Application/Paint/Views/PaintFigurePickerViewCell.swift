import UIKit

final class PaintFigurePickerViewCell: UICollectionViewCell {
    static let identifier = String(describing: PaintFigurePickerViewCell.self)
    lazy private var imageView = UIImageView(frame: bounds)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        layer.borderColor = UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFigure(withFigureType _figureType: FigureType) {
        let config = UIImage.SymbolConfiguration(pointSize: bounds.height / 2, weight: .thin)
        let image = UIImage(systemName: _figureType.icon, withConfiguration: config)
        imageView.image = image?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }
}
