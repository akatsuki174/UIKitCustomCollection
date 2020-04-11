//
//  PropertyEnumProtocol.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/11.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import Foundation

protocol PropertyEnumProtocol: RawRepresentable {
    var name: String { get }
}

extension PropertyEnumProtocol where RawValue == String {
    var name: String {
        return rawValue.camelToSpaceSeparatedWords()
    }
}
