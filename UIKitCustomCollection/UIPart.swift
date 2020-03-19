//
//  UIPart.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/19.
//  Copyright © 2020 akatsuki. All rights reserved.
//

enum UIPart: String, CaseIterable {
    case view
    case button
    case label
    case textField
    case textView
    case `switch`
    case segmentedControl
    case progressView
    case slider
    case stepper
    
    func name() -> String {
        switch self {
        case .view:
            return "UIView"
        case .button:
            return "UIButton"
        case .label:
            return "UILabel"
        case .textField:
            return "UITextField"
        case .textView:
            return "UITextView"
        case .switch:
            return "UISwitch"
        case .segmentedControl:
            return "UISegmentedControl"
        case .progressView:
            return "UIProgressView"
        case .slider:
            return "UISlider"
        case .stepper:
            return "UIStepper"
        }
    }
}
