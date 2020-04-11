//
//  BaseCell.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/29.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

protocol BaseCellProtocol: AnyObject {
    static var cellName: String { get }
    static func nib() -> UINib
    static var reuseIdentifier: String { get }
}

extension BaseCellProtocol {
    static func nib() -> UINib {
        return UINib(nibName: cellName, bundle: nil)
    }
    
    static var reuseIdentifier: String {
        get { return cellName }
    }
}
