import UIKit

final class DemotivatorViewController: UIViewController {
    private var demotivatorView: DemotivatorView? {
        view as? DemotivatorView
    }
    
    let image: UIImage
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"),
                                     style: .plain, target: self, action: #selector(saveButtonAction))
        return button
    }()
    
    lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "camera.filters"),
                                     style: .plain, target: self, action: #selector(filterButtonAction))
        return button
    }()
    
    lazy var editTextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                     style: .plain, target: self, action: #selector(editTextButtonAction))
        return button
    }()
    
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.rightBarButtonItems = [
            saveButton,
            filterButton,
            editTextButton
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = DemotivatorView(frame: view.bounds, image: image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func saveButtonAction() {
        getAlertControllerWithTextCallback(title: "Save Demotivator",
                                           message: "Write the filename of demotivator") { [weak self] (name) in
            guard let view = self?.demotivatorView else { return }
            let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
            let image = renderer.image { (ctx) in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
            guard name != "", FileStore.saveImage(withFileName: name, image) == true else { return }
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func filterButtonAction() {
        let alertController = UIAlertController(title: "Add filter",
                                                message: "Choose filter which will apply to the image",
                                                preferredStyle: .alert)
        
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
        getAlertControllerWithTextCallback(title: "Edit text",
                                           message: "Change the text of demotivator") { [weak self] (text) in
            self?.demotivatorView?.memLabel.text = text
        }
    }
}

extension DemotivatorViewController {
    func getAlertControllerWithTextCallback(title: String, message: String, completion: @escaping (String) -> Void) {
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
    
}

extension UIImage {
    func applyGrayscaleFilter() -> UIImage? {
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectNoir") {
            filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
    
    func applySepiaFilter() -> UIImage? {
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CISepiaTone") {
            filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            filter.setValue(0.5, forKey: kCIInputIntensityKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}
