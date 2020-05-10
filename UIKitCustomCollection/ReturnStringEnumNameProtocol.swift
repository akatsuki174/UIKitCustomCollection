//
//  PropertyEnumProtocol.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/11.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import Foundation

protocol ReturnStringEnumNameProtocol: RawRepresentable {
    var name: String { get }
}

extension ReturnStringEnumNameProtocol where RawValue == String {
    var name: String {
        return rawValue.camelToSpaceSeparatedWords()
    }
}
