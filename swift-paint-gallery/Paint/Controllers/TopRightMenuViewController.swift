//
//  TopRightMenuViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class TopRightMenuViewController: UIViewController, TopBarRightMenuDelegate {
    weak var delegate: TopBarRightMenuDelegate?
    
    private var topRightMenuView: TopRightMenuView? {
        view as? TopRightMenuView
    }
    override func loadView() {
        view = TopRightMenuView()
        view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topRightMenuView?.delegate = self
    }
    
    func setupConstraints(_ view: UIView) {
        topRightMenuView?.setupConstraints(view)
    }
    
    func undoPreviousDraw() {
        delegate?.undoPreviousDraw()
    }
    
    func saveImageLocally() {
        delegate?.saveImageLocally()
    }
}
