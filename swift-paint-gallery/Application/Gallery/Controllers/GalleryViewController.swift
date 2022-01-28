import UIKit

final class GalleryViewController: UIViewController {
    private var galleryCollectionView: GalleryCollectionView? {
        view as? GalleryCollectionView
    }
    
    private var imagesCount: Int {
        ImageStore.count
    }
    
    private func getImage(byIndex index: Int) -> Data? {
        ImageStore.getImage(byIndex: index)
    }
    
    override func loadView() {
        super.loadView()
        view = GalleryCollectionView(frame: view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery [\(imagesCount)]"
        galleryCollectionView?.delegate = self
        galleryCollectionView?.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        galleryCollectionView?.reloadData()
    }
    
    @objc private func navigateToPaintController() {
        navigationController?.pushViewController(PaintViewController(), animated: false)
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryImageCollectionViewCell.identifier,
                                                          for: indexPath) as! GalleryImageCollectionViewCell
            cell.setImage(image: UIImage(data: getImage(byIndex: indexPath.item - 1) ?? Data()))
            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: GalleryActionCollectionViewCell.identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            navigateToPaintController()
        } else {
            if let data = getImage(byIndex: indexPath.item - 1),
               let image = UIImage(data: data) {
                let galleryImageViewController = GalleryImageViewController()
                galleryImageViewController.setImage(image)
                present(galleryImageViewController, animated: true, completion: nil)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cellHeight = galleryCollectionView?
                                .cellForItem(at: IndexPath(row: 0, section: 0))?
                                .frame.height else { return }
        if scrollView.contentOffset.y > cellHeight - scrollView.safeAreaInsets.top {
            if navigationItem.rightBarButtonItem == nil {
                let button = PaintButton(size: 30, systemName: "plus")
                button.addTarget(self, action: #selector(navigateToPaintController), for: .touchUpInside)
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
            }
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
}
