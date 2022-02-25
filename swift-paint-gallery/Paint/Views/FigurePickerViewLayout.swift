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
    
    fileprivate static func getFigurePickerLayoutSize(width: CGFloat, height: CGFloat) -> NSCollectionLayoutSize {
        .init(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height))
    }
    
    fileprivate static func getFigurePickerItem() -> NSCollectionLayoutItem {
        let item: NSCollectionLayoutItem = .init(layoutSize: getFigurePickerLayoutSize(width: 3, height: 1))
        item.contentInsets = getDefaultInset()
        return item
    }
    
    fileprivate static func getFigurePickerHorizontalGroup() -> NSCollectionLayoutGroup {
        .horizontal(layoutSize: getFigurePickerLayoutSize(width: 1, height: 1),
                  subitems: [getFigurePickerItem()])
    }
    
    static func getFigurePickerCompositionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(section: NSCollectionLayoutSection(group: getFigurePickerHorizontalGroup()))
    }
}
