//
//  LabelViewModel.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/21.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class LabelViewModel {
    private let properties = LabelProperty.allCases
    private var isEnableBackgroundColor = false
    private var isEnableBorder = false
    private var isEnableRadius = false
    private var isEnableAdjustsFontSizeToFitWidth = false
    private var currentWords: [String] = ["Label"]
    private var currentBorderWidth: Double = 1
    private var currentRadiusValue: Double = 12
    private var currentLinesValue: Double = 1
    private var currentMinimumScaleFactor: Double = 0.7
    private var currentLineBreakModeValue: NSLineBreakMode = .byWordWrapping
    
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
            return (true, currentWords)
        case .backgroundColor:
            return (isEnableBackgroundColor, nil)
        case .border, .borderWidth:
            return (isEnableBorder, currentBorderWidth)
        case .radius, .radiusValue:
            return (isEnableRadius, currentRadiusValue)
        case .adjustsFontSizeToFitWidth:
            return (isEnableAdjustsFontSizeToFitWidth, currentMinimumScaleFactor)
        case .numberOfLines:
            return (true, currentLinesValue)
        case .lineBreakMode:
            return (true, currentLineBreakModeValue)
        case .minimumScaleFactor:
            return (true, currentMinimumScaleFactor)
        default:
            return (true, nil)
        }
    }
    
    func updateValue(property: LabelProperty, value: Any) {
        if let strArrayValue = value as? [String] {
            switch property {
            case .changeCharCount:
                currentWords = strArrayValue
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
            case .adjustsFontSizeToFitWidth:
                isEnableAdjustsFontSizeToFitWidth = boolValue
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
            case .minimumScaleFactor:
                currentMinimumScaleFactor = doubleValue
            default:
                ()
            }
        } else if let breakModeValue = value as? NSLineBreakMode {
            currentLineBreakModeValue = breakModeValue
        }
    }
    
    enum LabelProperty: String, CaseIterable, ReturnStringEnumNameProtocol {
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
    
    let programmingLanguages = ["Swift", "Objective-C", "Java", "Kotlin", "Ruby", "Python", "C", "C#", "PHP", "Perl", "Go", "Rust", "JavaScript", "Scala", "COBOL"]
}

extension NSLineBreakMode: ReturnStringEnumNameProtocol {
    static let allCases: [NSLineBreakMode] = [.byWordWrapping, .byCharWrapping, .byClipping, .byTruncatingHead, .byTruncatingTail, .byTruncatingMiddle]

    var name: String {
        switch self {
        case .byWordWrapping:
            return "byWordWrapping"
        case .byCharWrapping:
            return "byCharWrapping"
        case .byClipping:
            return "byClipping"
        case .byTruncatingHead:
            return "byTruncatingHead"
        case .byTruncatingTail:
            return "byTruncatingTail"
        case .byTruncatingMiddle:
            return "byTruncatingMiddle"
        default:
            return ""
        }
    }
}
