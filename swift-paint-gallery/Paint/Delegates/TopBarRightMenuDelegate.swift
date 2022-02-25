//
//  TopBarRightMenuDelegate.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import Foundation

protocol TopBarRightMenuDelegate: AnyObject {
    func undoPreviousDraw()
    func saveImageLocally()
}
