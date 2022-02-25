//
//  FigurePickerViewController.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class FigurePickerViewController: UIViewController {
    weak var accessor: PaintModelAccessor?
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: .getFigurePickerCompositionLayout()
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(FigurePickerViewCell.self,
                 forCellWithReuseIdentifier: FigurePickerViewCell.identifier)
        return collectionView
    }()
    
    let leftGradient = FigurePickerGradientView()
    let rightGradient = FigurePickerGradientView(startPoint: CGPoint(x: 1.0, y: 0.0), endPoint: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.addSubview(leftGradient)
        view.addSubview(rightGradient)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupConstraints(_ parentView: UIView) {
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.2),
            view.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: parentView.safeAreaLayoutGuide.layoutFrame.width * 0.2),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            leftGradient.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            leftGradient.heightAnchor.constraint(equalTo: view.heightAnchor),
            leftGradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftGradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rightGradient.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            rightGradient.heightAnchor.constraint(equalTo: view.heightAnchor),
            rightGradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightGradient.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FigurePickerViewController: UICollectionViewDelegate,
                                      UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        FigureType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FigurePickerViewCell.identifier,
            for: indexPath
        ) as? FigurePickerViewCell else { return FigurePickerViewCell() }
        cell.setFigure(withFigureType: FigureType.allCases[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FigurePickerViewCell.identifier,
            for: indexPath
        ) as? FigurePickerViewCell, let accessor = accessor else { return }
        
        UIView.animate(withDuration: 0.5, animations: {
            collectionView.bounds.origin.x = cell.frame.origin.x - cell.frame.width
        })
        accessor.paintModel.figureType = FigureType.allCases[indexPath.item]
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width * 0.2,
               height: view.safeAreaLayoutGuide.layoutFrame.width * 0.2)
    }
}
