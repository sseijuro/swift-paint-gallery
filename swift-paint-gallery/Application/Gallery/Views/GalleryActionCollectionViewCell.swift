import UIKit

final class GalleryActionCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GalleryActionCollectionViewCell.self)
    lazy private var triggerIcon = buildTriggerLabel(withText: "+", withSize: 36, withWeight: .bold)
    lazy private var triggerText = buildTriggerLabel(withText: "go draw :)", withSize: 18, withWeight: .regular)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        addSubview(triggerText)
        addSubview(triggerIcon)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryActionCollectionViewCell {
    private func buildTriggerLabel(withText text: String, withSize size: CGFloat,
                            withWeight weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: size, weight: weight)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            triggerIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            triggerIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            triggerText.bottomAnchor.constraint(equalTo: bottomAnchor,
                                          constant: triggerText.bounds.height - 5),
            triggerText.leadingAnchor.constraint(equalTo: leadingAnchor),
            triggerText.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
