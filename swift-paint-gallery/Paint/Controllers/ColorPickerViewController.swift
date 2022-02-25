//
//  ColorPickerViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class ColorPickerViewController: UIViewController {
    private var heightConstraint: NSLayoutConstraint?
    weak var accessor: PaintModelAccessor?
    
    var colorPickerView: UITableView? {
        view as? UITableView
    }
    
    private var colorsList: [UIColor] {
        PaintModel.colorsList
    }
    
    override func loadView() {
        view = UITableView(frame: .zero, style: .plain)
        view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        colorPickerView?.register(
            ColorPickerTableViewCell.self,
            forCellReuseIdentifier: ColorPickerTableViewCell.identifier
        )
        colorPickerView?.showsVerticalScrollIndicator = false
        colorPickerView?.delegate = self
        colorPickerView?.dataSource = self
    }
    
    func setupConstraints(_ view: UIView) {
        guard let tableView = colorPickerView else { return }
        heightConstraint = tableView.heightAnchor.constraint(equalToConstant: 30)
        if let heightConstraint = heightConstraint {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                tableView.widthAnchor.constraint(equalToConstant: 30),
                heightConstraint,
            ])
        }
    }
}

extension ColorPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorPickerTableViewCell.identifier) as! ColorPickerTableViewCell
        cell.setBackgroundColor(PaintModel.colorsList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let accessor = accessor else { return }
        if heightConstraint?.constant == 30 {
            heightConstraint?.constant = CGFloat(30 * (colorsList.count))
//            UIView.animate(withDuration: 0.5, animations: { [weak self] in
//                colorPickerView?.layoutIfNeeded()
//            })
        } else {
            heightConstraint?.constant = 30
            accessor.paintModel.color = colorsList[indexPath.item].cgColor
//            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                colorPickerView?.bounds.origin.y = CGFloat(indexPath.item) * 30
//                colorPickerView?.layoutIfNeeded()
//            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
}
