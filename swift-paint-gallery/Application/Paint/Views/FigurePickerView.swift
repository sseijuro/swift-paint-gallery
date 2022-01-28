import UIKit

final class FigurePickerView: UICollectionView {
    lazy var leftGradient = FigurePickerGradientView(locations: [0, 0.3],
                                                     startPoint: CGPoint(x: 0, y: 0),
                                                     endPoint: CGPoint(x: 1, y: 0))
    lazy var rightGradient = FigurePickerGradientView(locations: [0.7, 1],
                                                      startPoint: CGPoint(x: 1, y: 0),
                                                      endPoint: CGPoint(x: -1, y: 0))
    
    init() {
        super.init(frame: .zero, collectionViewLayout: .getFigurePickerCompositionLayout())
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        showsHorizontalScrollIndicator = false
        alwaysBounceVertical = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionViewLayout = flowLayout
        
        register(PaintFigurePickerViewCell.self,
                 forCellWithReuseIdentifier: PaintFigurePickerViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FigurePickerView {
    func setupConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
            heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width * 0.2),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                     constant: view.safeAreaLayoutGuide.layoutFrame.width * 0.2),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            leftGradient.heightAnchor.constraint(equalTo: heightAnchor),
            leftGradient.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            leftGradient.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            leftGradient.bottomAnchor.constraint(equalTo: bottomAnchor),

            rightGradient.heightAnchor.constraint(equalTo: heightAnchor),
            rightGradient.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            rightGradient.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rightGradient.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension UICollectionViewLayout {
    private static func getDefaultInset() -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: -1, bottom: -1, trailing: 0)
    }
    
    private static func getFigurePickerLayoutSize(width: CGFloat, height: CGFloat) -> NSCollectionLayoutSize {
        .init(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height))
    }
    
    private static func getFigurePickerItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getFigurePickerLayoutSize(width: 3, height: 1))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    private static func getFigurePickerHorizontalGroup() -> NSCollectionLayoutGroup {
        .horizontal(layoutSize: getFigurePickerLayoutSize(width: 1, height: 1),
                  subitems: [getFigurePickerItem()])
    }
    
    static func getFigurePickerCompositionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(section: NSCollectionLayoutSection(group: getFigurePickerHorizontalGroup()))
    }
}

