//
//  UICollectionViewLayout+extension.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

extension UICollectionViewLayout {
    fileprivate static func getDefaultInset() -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: -1, bottom: -1, trailing: 0)
    }
    
    fileprivate static func getGalleryLayoutSize(width: CGFloat, height: CGFloat) -> NSCollectionLayoutSize {
        .init(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height))
    }
    
    fileprivate static func getGallerySmallHorizontalItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getGalleryLayoutSize(width: 1/3, height: 1))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    fileprivate static func getGallerySmallVerticalItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getGalleryLayoutSize(width: 1, height: 1/2))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    fileprivate static func getGalleryBigItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getGalleryLayoutSize(width: 2/3, height: 1))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    fileprivate static func getGallerySmallHorizontalGroup() -> NSCollectionLayoutGroup {
        .horizontal(layoutSize: getGalleryLayoutSize(width: 1, height: 1/6), subitems: [getGallerySmallHorizontalItem()])
    }
    
    fileprivate static func getGallerySmallVerticalGroup() -> NSCollectionLayoutGroup {
        .vertical(layoutSize: getGalleryLayoutSize(width: 1/3, height: 1), subitems: [getGallerySmallVerticalItem()])
    }
    
    fileprivate static func getGalleryBigHorizontalGroup(atBegin: Bool = true) -> NSCollectionLayoutGroup {
        .horizontal(
            layoutSize: getGalleryLayoutSize(width: 1, height: 2/6),
            subitems: atBegin ? [
                getGalleryBigItem(),
                getGallerySmallVerticalGroup()
            ] : [
                getGallerySmallVerticalGroup(),
                getGalleryBigItem()
            ]
        )
    }
    
    fileprivate static func getGallerySectionLayout() -> NSCollectionLayoutSection {
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
