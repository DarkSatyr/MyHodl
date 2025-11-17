//
//  IconView.swift
//  MyHodl
//
//  Created by DarkSatyr on 14.11.2025.
//

import SwiftUI

struct IconView: View {
    let source: ImageSource
    @Environment(ThemeManager.self) private var themeManager

    var body: some View {
        switch source {
        case .bundle(let name):
            Image(name)
                .resizable()
                .scaledToFit()
        case .system(let symbol):
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
//        case .url(let url):
//            // зараз можна поставити заглушку,
//            // потім заміниш на AsyncImage / Kingfisher
//            AsyncImage(url: url) { phase in
//                switch phase {
//                case .success(let image):
//                    image.resizable().scaledToFit()
//                default:
//                    break
//                }
//            }
        case .placeholder:
            Image(systemName: "bitcoinsign.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(themeManager.currentTheme.text)
        }
    }
}

#Preview {
    IconView(source: .placeholder)
        .environment(ThemeManager())
}
