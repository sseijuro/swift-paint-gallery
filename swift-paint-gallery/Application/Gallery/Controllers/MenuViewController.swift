import UIKit

final class MenuViewController: UIViewController {
    lazy var tableView: UITableView = .initSimpleTableView(frame: view.bounds)
    
    let menuItems = ["Paint", "Demotivator"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        .setupSimpleMenuCell(tableView, text: menuItems[indexPath.item])
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

extension UITableView {
    static func initSimpleTableView(frame: CGRect) -> UITableView {
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.separatorStyle = .none
        return tableView
    }
}

extension UITableViewCell {
    static func setupSimpleMenuCell(_ tableView: UITableView, text: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        cell.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor)
        ])
        
        return cell
    }
}
