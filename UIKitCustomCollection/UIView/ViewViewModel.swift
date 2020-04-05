//
//  ViewViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/21.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import CoreGraphics

class ViewViewModel {
    private let properties = ViewProperty.allCases
    private var isEnableBackgroundColor = true
    private var isEnableBorder = false
    private var isEnableRadius = false
    private var isEnableShadow = false
    private var currentBorderWidth: Double = 1
    private var currentRadiusValue: Double = 12
    private var currentShadowOffset: CGSize = CGSize(width: 0, height: 0)
    private var currentShadowOpacity: Float = 0.7
    private var currentShadowRadius: CGFloat = 5
    
    func numberOfRows() -> Int {
        return properties.count
    }
    
    func property(index: Int) -> ViewProperty? {
        if index >= properties.count { return nil }
        return properties[index]
    }
    
    func getPropertyValues(property: ViewProperty) -> (isEnabled: Bool, value: Any?) {
        switch property {
        case .backgroundColor:
            return (isEnableBackgroundColor, nil)
        case .border, .borderWidth:
            return (isEnableBorder, currentBorderWidth)
        case .radius, .radiusValue:
            return (isEnableRadius, currentRadiusValue)
        case .shadow, .shadowOffset, .shadowOpacity, .shadowRadius:
            return (isEnableShadow, ShadowProperties(shadowOffset: currentShadowOffset, shadowOpacity: currentShadowOpacity, shadowRadius: currentShadowRadius))
        }
    }
    
    func updateValue(property: ViewProperty, value: Any) {
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
            default:
                ()
            }
        } else if let doubleValue = value as? Double {
            switch property {
            case .borderWidth:
                currentBorderWidth = doubleValue
            case .radiusValue:
                currentRadiusValue = doubleValue
            default:
                ()
            }
        } else if let shadowProperties = value as? ShadowProperties {
            switch property {
            case .shadowOffset:
                currentShadowOffset = shadowProperties.shadowOffset
            case .shadowOpacity:
                currentShadowOpacity = shadowProperties.shadowOpacity
            case .shadowRadius:
                currentShadowRadius = shadowProperties.shadowRadius
            default:
                ()
            }
        }
    }
    
    enum ViewProperty: String, CaseIterable {
        case backgroundColor
        case border
        case borderWidth
        case radius
        case radiusValue
        case shadow
        case shadowOffset
        case shadowOpacity // 濃さ
        case shadowRadius // ぼかし量
        
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
            case .radiusValue:
                return "radius value"
            case .shadow:
                return "shadow"
            case .shadowOffset:
                return "shadow offset"
            case .shadowOpacity:
                return "shadow opacity"
            case .shadowRadius:
                return "shadow radius"
            }
        }
        
        func customPattern() -> CustomPattern {
            switch self {
            case .backgroundColor, .border, .radius, .shadow:
                return .switch
            case .borderWidth, .radiusValue, .shadowOffset, .shadowOpacity, .shadowRadius:
                return .stepper
            }
        }
    }
}

struct ShadowProperties {
    let shadowOffset: CGSize
    let shadowOpacity: Float
    let shadowRadius: CGFloat
}
