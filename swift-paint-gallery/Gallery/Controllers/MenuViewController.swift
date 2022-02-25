//
//  MenuViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class MenuViewController: UIViewController {
    private var tableView: UITableView? {
        view as? UITableView
    }
    
    private let menuItems = ["Paint", "Demotivator"]
    
    override func loadView() {
        view = UITableView(frame: .zero, style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        
        tableView?.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self)
        )
        
        tableView?.separatorStyle = .none
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        else { return UITableViewCell() }
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = menuItems[indexPath.item]
        cell.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor)
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item <= menuItems.count else { return }
        
        if indexPath.item == 0 {
            navigationController?.pushViewController(PaintViewController(), animated: true)
        } else if indexPath.item == 1 {
            navigationController?.pushViewController(DemotivatorMenuViewController(), animated: true)
        }
    }
    
}
