import UIKit

final class GalleryImageViewController: UIViewController {
    private var image: UIImage?
    
    private var imageView: UIImageView? {
        view as? UIImageView
    }
    
    override func loadView() {
        super.loadView()
        view = UIImageView(frame: view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setImage(_ image: UIImage?) {
        imageView?.image = image
    }
}
