import UIKit

final class ColorPickerView: UITableView {
    lazy var heightConstraint = heightAnchor.constraint(equalToConstant: 30)
    
    init() {
        super.init(frame: .zero, style: .plain)
        translatesAutoresizingMaskIntoConstraints = false
        register(ColorPickerTableViewCell.self, forCellReuseIdentifier: ColorPickerTableViewCell.identifier)
        showsVerticalScrollIndicator = false
        layer.borderWidth = 1
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorPickerView {
    func setupConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 30),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heightConstraint,
        ])
    }
}
