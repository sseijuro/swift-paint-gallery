//
//  PaintViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class PaintViewController: UIViewController {
    private var _paintModel = PaintModel()
    
    private let canvasVC = CanvasViewController()
    private let colorPickerVC = ColorPickerViewController()
    private let topRightMenuVC = TopRightMenuViewController()
    private let figurePickerVC = FigurePickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(canvasVC.view)
        view.addSubview(colorPickerVC.view)
        view.addSubview(topRightMenuVC.view)
        view.addSubview(figurePickerVC.view)
        
        canvasVC.accessor = self
        colorPickerVC.accessor = self
        figurePickerVC.accessor = self
        
        topRightMenuVC.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        canvasVC.setupConstraints(view)
        colorPickerVC.setupConstraints(view)
        topRightMenuVC.setupConstraints(view)
        figurePickerVC.setupConstraints(view)
    }
    
}

extension PaintViewController: PaintModelAccessor {
    var paintModel: PaintModel {
        get { _paintModel }
        set { _paintModel = newValue }
    }
    
    var statusBarHeight: CGFloat {
        view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    }
    
    var navBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? 0.0
    }
}

// MARK: To implement: pass this reponsibility to the TopRightMenuController through access of CanvasView
extension PaintViewController: TopBarRightMenuDelegate {
    private func navigateBack() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func undoPreviousDraw() {
        guard let layers = canvasVC.view.layer.sublayers, layers.count > 0 else {
            return navigateBack()
        }
        canvasVC.view.layer.sublayers?.removeLast()
    }

    @objc func saveImageLocally() {
        showSaveAlertController { [weak self] (name) in
            guard let canvasView = self?.canvasVC.view else { return }
            let renderer = UIGraphicsImageRenderer(size: canvasView.bounds.size)
            let image = renderer.image { (ctx) in
                canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
            }
            guard let name = name, name != "",
                  let data = image.pngData(),
                  FileStorage.save(withFileName: name, data) == true
            else { return }
            self?.navigateBack()
        }
    }
    
    private func showSaveAlertController(completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(
            title: "Save image locally",
            message: "",
            preferredStyle: .alert
        )
        
        alertController.addTextField()
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            completion(alertController?.textFields?[0].text)
        }

        alertController.addAction(confirmAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
