//
//  ViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

class GalleryViewController: UIViewController {
    private var galleryView: UICollectionView? {
        view as? UICollectionView
    }
    
    private var imageURLs: [URL] {
        FileStorage.fileUrls
    }
    
    private var imagesCount: Int {
        imageURLs.count
    }
    
    override func loadView() {
        view = UICollectionView(frame: .zero, collectionViewLayout: .getGalleryCompositionLayout())
        galleryView?.register(
            GalleryActionCollectionViewCell.self,
            forCellWithReuseIdentifier: GalleryActionCollectionViewCell.identifier
        )
        galleryView?.register(
            GalleryImageCollectionViewCell.self,
            forCellWithReuseIdentifier: GalleryImageCollectionViewCell.identifier
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        galleryView?.reloadData()
        updateNavTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        galleryView?.delegate = self
        galleryView?.dataSource = self
    }
    
    private func getData(byIndex index: Int) -> Data? {
        UserDefaultsStorage.get(byIndex: index)
    }
    
    private func updateNavTitle() {
        title = "Gallery [\(imagesCount)]"
    }

    @objc private func navigateToMenuController() {
        navigationController?.pushViewController(MenuViewController(), animated: true)
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryActionCollectionViewCell.identifier,
                for: indexPath
            )
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GalleryImageCollectionViewCell.identifier,
            for: indexPath
        ) as! GalleryImageCollectionViewCell
        
        if let data = try? Data(contentsOf: imageURLs[indexPath.item - 1]) {
            cell.setImage(image: UIImage(data: data))
            cell.setName(name: imageURLs[indexPath.item - 1].lastPathComponent)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            navigateToMenuController()
        } else {
            if let data = try? Data(contentsOf: imageURLs[indexPath.item - 1]),
               let image = UIImage(data: data) {
                let galleryImageViewController = GalleryImageViewController()
                galleryImageViewController.setImage(image)
                present(galleryImageViewController, animated: true, completion: nil)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cellHeight = galleryView?
                .cellForItem(at: IndexPath(row: 0, section: 0))?
                .frame.height else { return }
        if scrollView.contentOffset.y > cellHeight - scrollView.safeAreaInsets.top {
            if navigationItem.rightBarButtonItem == nil {
                let toMenubutton = PGDButton(size: 30, systemName: "plus", color: .black, weight: .bold)
                toMenubutton.addTarget(self, action: #selector(navigateToMenuController), for: .touchUpInside)
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: toMenubutton)
            }
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
}
