//
//  LabelViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/21.
//  Copyright © 2020 akatsuki. All rights reserved.
//

class LabelViewModel {
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
    }
}
