//
//  DemotivatorViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class DemotivatorViewController: UIViewController {
    private var demotivatorView: DemotivatorView? {
        view as? DemotivatorView
    }
    
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DemotivatorView(frame: .zero, image: image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "square.and.arrow.down"),
                style: .plain,
                target: self,
                action: #selector(saveButtonAction)
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "camera.filters"),
                style: .plain,
                target: self,
                action: #selector(filterButtonAction)
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "pencil"),
                style: .plain,
                target: self,
                action: #selector(editTextButtonAction)
            )
        ]
    }
    
    private func getAlertControllerWithTextCallback(
        title: String,
        message: String,
        completion: @escaping (String) -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.text = self.demotivatorView?.memLabel.text ?? ""
        })
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            guard let text = alertController.textFields?[0].text else { return }
            completion(text)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func saveButtonAction() {
        getAlertControllerWithTextCallback(
            title: "Save Demotivator",
            message: "Write the filename of demotivator"
        ) { [weak self] (name) in
            guard let view = self?.demotivatorView else { return }
            let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
            let image = renderer.image { (ctx) in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
            guard name != "", let data = image.pngData(),
                  FileStorage.save(withFileName: name, data) == true
            else { return }
            
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func filterButtonAction() {
        let alertController = UIAlertController(
            title: "Add filter",
            message: "Choose filter which will apply to the image",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "Sepia", style: .default, handler: { [weak self] _ in
            guard let image = self?.demotivatorView?.imageView.image?.applySepiaFilter() else { return }
            self?.demotivatorView?.imageView.image = image
        }))
        
        alertController.addAction(UIAlertAction(title: "Grayscale", style: .default, handler: { [weak self] _ in
            guard let image = self?.demotivatorView?.imageView.image?.applyGrayscaleFilter() else { return }
            self?.demotivatorView?.imageView.image = image
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func editTextButtonAction() {
        getAlertControllerWithTextCallback(
            title: "Edit text",
            message: "Change the text of demotivator"
        ) { [weak self] (text) in
            self?.demotivatorView?.memLabel.text = text
        }
    }
}

