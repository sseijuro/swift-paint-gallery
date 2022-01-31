import UIKit

final class GalleryActionCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GalleryActionCollectionViewCell.self)
    lazy private var triggerIcon = buildTriggerLabel(withText: "+",
                                                     withSize: 36,
                                                     withWeight: .bold,
                                                     withBackground: false)
    lazy private var triggerText = buildTriggerLabel(withText: "create",
                                                     withSize: 18,
                                                     withWeight: .medium)
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
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            triggerIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            triggerIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            triggerText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: triggerText.bounds.height - 5),
            triggerText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            triggerText.widthAnchor.constraint(equalTo: widthAnchor, constant: -50)
        ])
    }
}
