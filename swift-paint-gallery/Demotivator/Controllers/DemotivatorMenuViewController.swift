//
//  DemotivatorMenuViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class DemotivatorMenuViewController: UIViewController  {
    private let imagePicker = UIImagePickerController()
    
    private var tableView: UITableView? {
        view as? UITableView
    }
    
    private let menuItems = ["Take photo from PhotoGallery", "Take photo from Camera"]
    
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

extension DemotivatorMenuViewController: UITableViewDelegate,
                                         UITableViewDataSource,
                                         UIImagePickerControllerDelegate,
                                         UINavigationControllerDelegate {
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
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            }
        } else if indexPath.item == 1 {
            let alert = UIAlertController(
                title: "Error",
                message: "Device not found, simulator detected",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else { return }
        navigationController?.pushViewController(DemotivatorViewController(image: image), animated: true)
    }
}
