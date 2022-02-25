//
//  UDStore.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class UserDefaultsStorage {
    private static let storeKey = String(describing: UserDefaultsStorage.self)
    
    private static var dataArray: [Data] {
        get { UserDefaults.standard.array(forKey: storeKey) as? [Data] ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: storeKey) }
    }
    
    static var count: Int { dataArray.count }
    
    static func get(byIndex index: Int) -> Data? {
        guard dataArray.count > index else { return nil }
        return dataArray[index]
    }
    
    static func set(data: Data) {
        var newDataArray = dataArray
        newDataArray.append(data)
        dataArray = newDataArray
    }
}
