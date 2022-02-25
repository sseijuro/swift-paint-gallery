//
//  GalleryImageCollectionViewCell.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class GalleryImageCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GalleryImageCollectionViewCell.self)
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy private var imageLabel = buildGalleryCollectionViewCellLabel(
        withText: "",
        withSize: 18,
        withWeight: .regular
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(imageLabel)
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage?) {
        imageView.image = image
    }
    
    func setName(name: String?) {
        imageLabel.text = name
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: imageLabel.bounds.height - 5),
            imageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            imageLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -50)
        ])
    }
}
