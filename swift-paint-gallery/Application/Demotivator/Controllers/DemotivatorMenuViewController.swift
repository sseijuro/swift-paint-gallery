import UIKit

final class DemotivatorMenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    lazy var tableView: UITableView = .initSimpleTableView(frame: view.bounds)
    let imagePicker = UIImagePickerController()
    
    let menuItems = ["Take photo from PhotoGallery", "Take photo from Camera"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else { return }
        navigationController?.pushViewController(DemotivatorViewController(image: image), animated: true)
    }
    
}

extension DemotivatorMenuViewController: UITableViewDelegate, UITableViewDataSource {
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
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            }
        } else if indexPath.item == 1 {
            let alert = UIAlertController(title: "Error",
                                          message: "Device not found, simulator detected",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
