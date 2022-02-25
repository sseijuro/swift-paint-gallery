//
//  GalleryImageViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class GalleryImageViewController: UIViewController {
    private var image: UIImage?
    
    private var imageView: UIImageView? {
        view as? UIImageView
    }
    
    override func loadView() {
        view = UIImageView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setImage(_ image: UIImage?) {
        imageView?.image = image
    }
    
}
