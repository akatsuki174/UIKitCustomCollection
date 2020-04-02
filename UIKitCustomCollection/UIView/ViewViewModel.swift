//
//  ViewViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/21.
//  Copyright © 2020 akatsuki. All rights reserved.
//

class ViewViewModel {
    private let properties = ViewProperty.allCases
    private var isEnableBackgroundColor = true
    private var isEnableBorder = false
    private var isEnableRadius = false
    private var isEnableShadow = false
    private var currentBorderWidth: Double = 1
    private var currentRadiusValue: Double = 5
    private var currentShadowWidth: Double = 3
    
    func numberOfRows() -> Int {
        return properties.count
    }
    
    func property(index: Int) -> ViewProperty? {
        if index >= properties.count { return nil }
        return properties[index]
    }
    
    func getPropertyValues(property: ViewProperty) -> (isEnabled: Bool, value: Double?) {
        switch property {
        case .backgroundColor:
            return (isEnableBackgroundColor, nil)
        case .border, .borderWidth:
            return (isEnableBorder, currentBorderWidth)
        case .radius, .radiusValue:
            return (isEnableRadius, currentRadiusValue)
        case .shadow, .shadowWidth:
            return (isEnableShadow, currentShadowWidth)
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
            case .shadowWidth:
                currentShadowWidth = doubleValue
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
            case .radiusValue:
                return "radius value"
            case .shadow:
                return "shadow"
            case .shadowWidth:
                return "shadow width"
            }
        }
        
        func customPattern() -> CustomPattern {
            switch self {
            case .backgroundColor, .border, .radius, .shadow:
                return .switch
            case .borderWidth, .radiusValue, .shadowWidth:
                return .stepper
            }
        }
    }
}

