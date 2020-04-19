//
//  ButtonViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/13.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class ButtonViewModel {
    private let properties = ButtonProperty.allCases
    private var isEnableBackgroundColor = false
    private var isEnableBorder = false
    private var isEnableRadius = false
    private var isEnableShadow = false
    private var isEnableTappedText = false
    private var isEnabletappedTextColor = false
    private var isEnableDisabledText = false
    private var isEnableDisabledTextColor = false
    private var isEnableImage = false
    private var isEnableBackgroundImage = false
    private var currentBorderWidth: Double = 1
    private var currentRadiusValue: Double = 12
    private var currentShadowOffset: CGSize = CGSize(width: 0, height: 0)
    private var currentShadowOpacity: Double = 0.7
    private var currentShadowRadius: Double = 5
    
    var defaultHighlightTextColor: UIColor? = nil
    var defaultDisabledTextColor: UIColor? = nil
    
    func numberOfRows() -> Int {
        return properties.count
    }
    
    func property(index: Int) -> ButtonProperty? {
        if index >= properties.count { return nil }
        return properties[index]
    }
    
    func getPropertyValues(property: ButtonProperty) -> (isEnabled: Bool, value: Any?) {
        switch property {
        case .backgroundColor:
            return (isEnableBackgroundColor, nil)
        case .border, .borderWidth:
            return (isEnableBorder, currentBorderWidth)
        case .radius, .radiusValue:
            return (isEnableRadius, currentRadiusValue)
        case .shadow, .shadowOffset, .shadowOpacity, .shadowRadius:
            return (isEnableShadow, ShadowProperties(shadowOffset: currentShadowOffset, shadowOpacity: currentShadowOpacity, shadowRadius: currentShadowRadius))
        case .tappedText:
            return (isEnableTappedText, nil)
        case .tappedTextColor:
            return (isEnabletappedTextColor, nil)
        case .disabledText:
            return (isEnableDisabledText, nil)
        case .disabledTextColor:
            return (isEnableDisabledTextColor, nil)
        case .image:
            return (isEnableImage, nil)
        case .backgroundImage:
            return (isEnableBackgroundImage, nil)
        }
    }
    
    func updateValue(property: ButtonProperty, value: Any) {
        if let boolValue = value as? Bool {
            switch property {
            case .backgroundColor:
                isEnableBackgroundColor = boolValue
            case .border:
                isEnableBorder = boolValue
            case .radius:
                isEnableRadius = boolValue
            case .shadow:
                isEnableShadow = boolValue
            case .tappedText:
                isEnableTappedText = boolValue
            case .tappedTextColor:
                isEnabletappedTextColor = boolValue
            case .disabledText:
                isEnableDisabledText = boolValue
            case .disabledTextColor:
                isEnableDisabledTextColor = boolValue
            default:
                ()
            }
        } else if let doubleValue = value as? Double {
            switch property {
            case .borderWidth:
                currentBorderWidth = doubleValue
            case .radiusValue:
                currentRadiusValue = doubleValue
            case .shadowOffset:
                currentShadowOffset = CGSize(width: doubleValue, height: doubleValue)
            case .shadowOpacity:
                currentShadowOpacity = doubleValue
            case .shadowRadius:
                currentShadowRadius = doubleValue
            default:
                ()
            }
        }
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
        case disabledText
        case disabledTextColor
        case image
        case backgroundImage
        
        func customPattern() -> CustomPattern {
            switch self {
            case .backgroundColor, .border, .radius, .shadow, .tappedText, .tappedTextColor, .disabledText, .disabledTextColor, .image, .backgroundImage:
                return .switch
            case .borderWidth, .radiusValue, .shadowOffset, .shadowOpacity, .shadowRadius:
                return .stepper
            }
        }
    }
}
