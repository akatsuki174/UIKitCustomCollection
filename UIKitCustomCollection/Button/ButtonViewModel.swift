//
//  ButtonViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/13.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import Foundation

class ButtonViewModel {
    private let properties = ButtonProperty.allCases
    
    func numberOfRows() -> Int {
        return properties.count
    }
    
    func property(index: Int) -> ButtonProperty? {
        if index >= properties.count { return nil }
        return properties[index]
    }
    
    enum ButtonProperty: String, CaseIterable, PropertyEnumProtocol {
        case backgroundColor
        case border
        case borderWidth
        case radius
        case radiusValue
        case shadow
        case shadowOffset
        case shadowOpacity // 濃さ
        case shadowRadius // ぼかし量
        case tappedText
        case tappedTextColor
        case image
        case backgroundImage
        
        func customPattern() -> CustomPattern {
            switch self {
            case .backgroundColor, .border, .radius, .shadow, .tappedText, .tappedTextColor, .image, .backgroundImage:
                return .switch
            case .borderWidth, .radiusValue, .shadowOffset, .shadowOpacity, .shadowRadius:
                return .stepper
            }
        }
    }
}
