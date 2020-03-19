//
//  TopViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/18.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import Foundation

class TopViewModel {
    private let parts = UIPart.allCases
    
    func numberOfRows() -> Int {
        return parts.count
    }
    
    func part(index: Int) -> UIPart? {
        if index >= parts.count { return nil }
        return parts[index]
    }
}
