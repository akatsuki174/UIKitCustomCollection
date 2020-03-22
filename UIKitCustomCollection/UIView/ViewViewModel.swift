//
//  ViewViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/21.
//  Copyright © 2020 akatsuki. All rights reserved.
//

class ViewViewModel {
    private let properties = ViewProperty.allCases
    
    func numberOfRows() -> Int {
        return properties.count
    }
    
    func property(index: Int) -> ViewProperty? {
        if index >= properties.count { return nil }
        return properties[index]
    }
    
    enum ViewProperty: String, CaseIterable {
        case backgroundColor
        case border
        case borderWidth
        case radius
        case shadow
        case shadowWidth
        
        func name() -> String {
            switch self {
            case .backgroundColor:
                return "background color"
            case .border:
                return "border"
            case .borderWidth:
                return "border width"
            case .radius:
                return "radius"
            case .shadow:
                return "shadow"
            case .shadowWidth:
                return "shadow width"
            }
        }
    }
}

