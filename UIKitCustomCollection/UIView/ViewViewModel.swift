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

