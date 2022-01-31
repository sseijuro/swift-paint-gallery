import UIKit

extension UICollectionViewCell {
    func buildTriggerLabel(withText text: String, withSize size: CGFloat,
                                   withWeight weight: UIFont.Weight,
                                   withBackground background: Bool = true) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: size, weight: weight)
        label.textAlignment = .center
        if background {
            label.textColor = .black
            label.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        } else {
            label.textColor = .white
        }
        return label
    }
}
