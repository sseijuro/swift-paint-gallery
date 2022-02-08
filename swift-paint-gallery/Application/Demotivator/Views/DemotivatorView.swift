import UIKit

final class DemotivatorView: UIView {
    lazy var memView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var memLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Mem text"
        return label
    }()
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        addSubview(memView)
        memView.addSubview(imageView)
        memView.addSubview(memLabel)
        imageView.image = image
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DemotivatorView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            memView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            memView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            memView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            memView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            imageView.widthAnchor.constraint(equalTo: memView.widthAnchor, multiplier: 0.75),
            imageView.heightAnchor.constraint(equalTo: memView.heightAnchor, multiplier: 0.60),
            imageView.centerXAnchor.constraint(equalTo: memView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: memView.topAnchor, constant: 100),
            
            memLabel.bottomAnchor.constraint(equalTo: memView.bottomAnchor, constant: -100),
            memLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            memLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
        ])
    }
}
