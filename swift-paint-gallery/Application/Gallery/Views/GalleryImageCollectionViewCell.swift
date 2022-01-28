import UIKit

final class GalleryImageCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GalleryImageCollectionViewCell.self)
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    lazy private var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.layer.opacity = 0.7
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            
//            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
//            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage?) {
        imageView.image = image
    }
    
    func setName(name: String?) {
        label.text = name
    }
}
