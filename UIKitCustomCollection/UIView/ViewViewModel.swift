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
    
    func isEnableProperty(property: ViewProperty) -> Bool? {
        switch property {
        case .backgroundColor:
            return isEnableBackgroundColor
        case .border:
            return isEnableBorder
        case .radius:
            return isEnableRadius
        case .shadow:
            return isEnableShadow
        default:
            return nil
        }
    }
    
    func propertyValue(property: ViewProperty) -> Double? {
        switch property {
        case .border, .borderWidth:
            return currentBorderWidth
        case .radius, .radiusValue:
            return currentRadiusValue
        case .shadow, .shadowWidth:
            return currentShadowWidth
        default:
            return nil
        }
    }
    
    func propertyBool(property: ViewProperty) -> Bool? {
        switch property {
        case .border, .borderWidth:
            return isEnableBorder
        case .radius, .radiusValue:
            return isEnableRadius
        case .shadow, .shadowWidth:
            return isEnableShadow
        default:
            return nil
        }
    }
    
    func updateValue(property: ViewProperty, value: Double) {
        switch property {
        case .borderWidth:
            currentBorderWidth = value
        case .radiusValue:
            currentRadiusValue = value
        case .shadowWidth:
            currentShadowWidth = value
        default:
            ()
        }
    }
    
    func updateValueBool(property: ViewProperty, value: Bool) {
        switch property {
        case .backgroundColor:
            isEnableBackgroundColor = value
        case .border:
            isEnableBorder = value
        case .radius:
            isEnableRadius = value
        case .shadow:
            isEnableShadow = value
        default:
            ()
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

