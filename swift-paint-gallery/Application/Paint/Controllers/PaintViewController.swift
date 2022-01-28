import UIKit

protocol PaintModelGetterDelegate: AnyObject {
    var color: CGColor { get }
    var width: CGFloat { get }
    var colorsList: [UIColor] { get }
}

protocol FigureModelDelegate: AnyObject {
    func pushFigure()
    func pushPointToLastFigure(_ point: CGPoint)
}

protocol DrawDelegate: AnyObject {
    func draw(atLayer layer: CALayer)
}

typealias CanvasDelegate = PaintModelGetterDelegate & FigureModelDelegate & DrawDelegate

protocol TopBarRightMenuDelegate: AnyObject {
    func undoPreviousDraw()
    func saveImageLocally()
}

final class PaintViewController: UIViewController, TopBarRightMenuDelegate {
    private var paintModel = PaintModel()
    private var paintView: PaintView? { view as? PaintView }
    
    override func loadView() {
        super.loadView()
        view = PaintView(frame: view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        paintView?.setupConstraints()
        paintView?.topRightMenuView.delegate = self
        paintView?.canvasView.delegate = self
        
        paintView?.figurePickerView.delegate = self
        paintView?.figurePickerView.dataSource = self
        
        paintView?.colorPickerView.dataSource = self
        paintView?.colorPickerView.delegate = self
    }
    
    func navigateBackToGallery() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func undoPreviousDraw() {
        guard let layers = paintView?.canvasView.layer.sublayers, layers.count > 0 else {
            return navigateBackToGallery()
        }
        paintView?.canvasView.layer.sublayers?.removeLast()
    }

    @objc func saveImageLocally() {
        showSaveAlertController { [weak self] (name) in
            guard let canvasView = self?.paintView?.canvasView else { return }
            let renderer = UIGraphicsImageRenderer(size: canvasView.bounds.size)
            let image = renderer.image { (ctx) in
                canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
            }
            ImageStore.addImage(image: image)
            print(name)
            self?.navigateBackToGallery()
        }
    }
}

extension PaintViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PaintModel.colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorPickerTableViewCell.identifier) as! ColorPickerTableViewCell
        cell.setBackgroundColor(colorsList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let heightConstraint = paintView?.colorPickerView.heightConstraint else { return }
        if heightConstraint.constant == 30 {
            paintView?.colorPickerView.heightConstraint.constant = CGFloat(30 * (colorsList.count))
            UIView.animate(withDuration: 0.5, animations: {
                self.paintView?.layoutIfNeeded()
            })
        } else {
            paintView?.colorPickerView.heightConstraint.constant = 30
            paintModel.color = colorsList[indexPath.item].cgColor
            UIView.animate(withDuration: 0.5, animations: {
                self.paintView?.colorPickerView.bounds.origin.y = CGFloat(indexPath.item) * 30
                self.paintView?.layoutIfNeeded()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
}

extension PaintViewController: CanvasDelegate {
    private var statusBarHeight: CGFloat {
        view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    }
    
    private var navBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    var color: CGColor {
        paintModel.color
    }
    
    var width: CGFloat {
        paintModel.width
    }
    
    var colorsList: [UIColor] {
        PaintModel.colorsList
    }
    
    func pushFigure() {
        let newFigure = FigureModel(figureType: paintModel.figureType)
        paintModel.figures.count == 0 ?
            paintModel.figures.append(newFigure) :
                (paintModel.figures[0] = newFigure)
    }
    
    func pushPointToLastFigure(_ point: CGPoint) {
        paintModel.figures[paintModel.figures.count - 1].points
            .append(CGPoint(x: point.x, y: point.y - statusBarHeight - navBarHeight))
    }
    
    func draw(atLayer layer: CALayer) {
        guard let figure = paintModel.figures.last else { return }
        drawByConcreteStrategy(atLayer: layer, points: figure.points)
    }
    
    
}

extension PaintViewController:
    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        FigureType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaintFigurePickerViewCell.identifier, for: indexPath) as! PaintFigurePickerViewCell
        cell.setFigure(withFigureType: FigureType.allCases[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaintFigurePickerViewCell.identifier, for: indexPath) as! PaintFigurePickerViewCell
        UIView.animate(withDuration: 0.5, animations: {
            collectionView.bounds.origin.x = cell.frame.origin.x - cell.frame.width
        })
        paintModel.figureType = FigureType.allCases[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width * 0.2,
                      height: view.safeAreaLayoutGuide.layoutFrame.width * 0.2)
    }
}

extension PaintViewController {
    func drawByConcreteStrategy(atLayer layer: CALayer, points: [CGPoint]) {
         guard let lastFigure = paintModel.figures.last else { return }
         switch lastFigure.figureType {
             case .CurveLine:
                 PaintDrawCurveLineStrategy.draw(atLayer: layer, points: points)
             case .Line:
                 PaintDrawLineStrategy.draw(atLayer: layer, points: points)
             case .Rectangle:
                 PaintDrawRectangleStrategy.draw(atLayer: layer, points: points)
             case .Triangle:
                 PaintDrawTriangleStrategy.draw(atLayer: layer, points: points)
             case .Circle:
                 PaintDrawCircleStrategy.draw(atLayer: layer, points: points)
         }
    }
    
    private func showSaveAlertController(completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "Save image locally",
                                                message: "", preferredStyle: .alert)
        alertController.addTextField()
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            completion(alertController?.textFields?[0].text)
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
