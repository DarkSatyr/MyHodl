//
//  Text+Hodl.swift
//  MyHodl
//
//  Created by DarkSatyr on 16.02.2026.
//

import SwiftUI

extension Text {
    init(optional value: String?, fallback: String = "—") {
        self.init(value ?? fallback)
    }
}
