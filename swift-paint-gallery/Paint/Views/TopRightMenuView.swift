//
//  TopRightMenuView.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class TopRightMenuView: UIStackView {
    weak var delegate: TopBarRightMenuDelegate?

    private(set) lazy var saveButton: UIButton = {
        let button = PGDButton(
            size: 30,
            systemName: "checkmark",
            color: .systemBlue,
            weight: .regular
        )
        button.addTarget(self, action: #selector(saveImageLocally), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var undoButton: UIButton = {
        let button = PGDButton(
            size: 30,
            systemName: "arrow.uturn.backward",
            color: .systemBlue,
            weight: .regular
        )
        button.addTarget(self, action: #selector(undoPreviousDraw), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fillEqually
        spacing = 2.5
        addArrangedSubview(undoButton)
        addArrangedSubview(saveButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 62.5),
            heightAnchor.constraint(equalToConstant: 30),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
    
    @objc func saveImageLocally() {
        delegate?.saveImageLocally()
    }
    
    @objc func undoPreviousDraw() {
        delegate?.undoPreviousDraw()
    }
}
