import UIKit

final class GalleryCollectionView: UICollectionView {
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: .getGalleryCompositionLayout())
        register(GalleryActionCollectionViewCell.self,
                 forCellWithReuseIdentifier: GalleryActionCollectionViewCell.identifier)
        register(GalleryImageCollectionViewCell.self,
                 forCellWithReuseIdentifier: GalleryImageCollectionViewCell.identifier)
        bounces = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionViewLayout {
    private static func getDefaultInset() -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: -1, bottom: -1, trailing: 0)
    }
    
    private static func getGalleryLayoutSize(width: CGFloat, height: CGFloat) -> NSCollectionLayoutSize {
        .init(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height))
    }
    
    private static func getGallerySmallHorizontalItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getGalleryLayoutSize(width: 1/3, height: 1))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    private static func getGallerySmallVerticalItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getGalleryLayoutSize(width: 1, height: 1/2))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    private static func getGalleryBigItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getGalleryLayoutSize(width: 2/3, height: 1))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    private static func getGallerySmallHorizontalGroup() -> NSCollectionLayoutGroup {
        .horizontal(layoutSize: getGalleryLayoutSize(width: 1, height: 1/6), subitems: [getGallerySmallHorizontalItem()])
    }
    
    private static func getGallerySmallVerticalGroup() -> NSCollectionLayoutGroup {
        .vertical(layoutSize: getGalleryLayoutSize(width: 1/3, height: 1), subitems: [getGallerySmallVerticalItem()])
    }
    
    private static func getGalleryBigHorizontalGroup(atBegin: Bool = true) -> NSCollectionLayoutGroup {
        .horizontal(layoutSize: getGalleryLayoutSize(width: 1, height: 2/6),
                    subitems: atBegin ? [getGalleryBigItem(), getGallerySmallVerticalGroup()] : [getGallerySmallVerticalGroup(), getGalleryBigItem()])
    }
    
    private static func getGallerySectionLayout() -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.vertical(layoutSize: getGalleryLayoutSize(width: 1, height: 1),
                                                     subitems: [
                                                        getGallerySmallHorizontalGroup(),
                                                        getGalleryBigHorizontalGroup(),
                                                        getGallerySmallHorizontalGroup(),
                                                        getGalleryBigHorizontalGroup(atBegin: false)
                                                     ])
        return NSCollectionLayoutSection(group: group)
    }

    static func getGalleryCompositionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(section: getGallerySectionLayout())
    }
}
