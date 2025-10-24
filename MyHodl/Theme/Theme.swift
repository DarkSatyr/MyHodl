//
//  Theme.swift
//  MyHodl
//
//  Created by DarkSatyr on 23.10.2025.
//

import SwiftUI

protocol Theme {
    var backgroundColor: Color { get }
    var type: ThemeType { get }
}

struct DarkTheme: Theme {
    let backgroundColor = Color.black
    let type = ThemeType.dark
}

struct LightTheme: Theme {
    let backgroundColor = Color.white
    let type = ThemeType.light
}
