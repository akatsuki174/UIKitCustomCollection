//
//  LabelViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/21.
//  Copyright © 2020 akatsuki. All rights reserved.
//

class LabelViewModel {
    private let properties = LabelProperty.allCases
    private var isEnableBackgroundColor = false
    private var isEnableBorder = false
    private var isEnableRadius = false
    private var currentString = "Label"
    private var currentBorderWidth: Double = 1
    private var currentRadiusValue: Double = 12
    private var currentLinesValue: Double = 1
    
    func numberOfRows() -> Int {
        return properties.count
    }
    
    func property(index: Int) -> LabelProperty? {
        if index >= properties.count { return nil }
        return properties[index]
    }
    
    func getPropertyValues(property: LabelProperty) -> (isEnabled: Bool, value: Any?) {
        switch property {
        case .changeCharCount:
            return (true, currentString)
        case .backgroundColor:
            return (isEnableBackgroundColor, nil)
        case .border, .borderWidth:
            return (isEnableBorder, currentBorderWidth)
        case .radius, .radiusValue:
            return (isEnableRadius, currentRadiusValue)
        case .numberOfLines:
            return (true, currentLinesValue)
        default:
            return (true, nil)
        }
    }
    
    func updateValue(property: LabelProperty, value: Any) {
        if let strValue = value as? String {
            switch property {
            case .changeCharCount:
                currentString = strValue
            default:
                ()
            }
        } else if let boolValue = value as? Bool {
            switch property {
            case .backgroundColor:
                isEnableBackgroundColor = boolValue
            case .border:
                isEnableBorder = boolValue
            case .radius:
                isEnableRadius = boolValue
            default:
                ()
            }
        } else if let doubleValue = value as? Double {
            switch property {
            case .borderWidth:
                currentBorderWidth = doubleValue
            case .radiusValue:
                currentRadiusValue = doubleValue
            case .numberOfLines:
                currentLinesValue = doubleValue
            default:
                ()
            }
        }
    }
    
    enum LabelProperty: String, CaseIterable, PropertyEnumProtocol {
        case changeCharCount
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
            case .changeCharCount, .borderWidth, .radiusValue, .numberOfLines, .minimumScaleFactor, .shadowOffset, .shadowColor:
                return .stepper
            case .lineBreakMode, .textAlignment, .baselineAdjustment:
                return .detail
            }
        }
    }
}
