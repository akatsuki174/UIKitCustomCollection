//
//  LabelViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/21.
//  Copyright © 2020 akatsuki. All rights reserved.
//

class LabelViewModel {
    private let properties = LabelProperty.allCases
    
    func numberOfRows() -> Int {
        return properties.count
    }
    
    func property(index: Int) -> LabelProperty? {
        if index >= properties.count { return nil }
        return properties[index]
    }
    
    enum LabelProperty: String, CaseIterable, PropertyEnumProtocol {
        case increaseCharacters
        case backgroundColor
        case border
        case borderWidth
        case radius
        case radiusValue
        case numberOfLines
        case lineBreakMode
        case adjustsFontSizeToFitWidth
        case minimumScaleFactor
        case shadowOffset
        case shadowColor
        case textColor
        case textAlignment
        case baselineAdjustment
        case tappedTextColor

        func customPattern() -> CustomPattern {
            switch self {
            case .backgroundColor, .border, .radius, .adjustsFontSizeToFitWidth, .textColor, .tappedTextColor:
                return .switch
            case .increaseCharacters, .borderWidth, .radiusValue, .numberOfLines, .minimumScaleFactor, .shadowOffset, .shadowColor:
                return .stepper
            case .lineBreakMode, .textAlignment, .baselineAdjustment:
                return .detail
            }
        }
    }
}
