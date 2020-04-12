//
//  CharacterExtension.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/11.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import Foundation

extension String {
    // ex) hogeFuga -> hoge fuga
    func camelToSpaceSeparatedWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                return ($0 + " " + String($1).lowercased())
            } else {
                return $0 + String($1)
            }
        }
    }
}
