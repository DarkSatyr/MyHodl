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
    
    private var placeholder: Image {
        Image(systemName: "bitcoinsign.circle")
    }

    var body: some View {
        switch source {
        case .local(let name):
            Image(safe: name?.lowercased(), placeholder: placeholder)
                .resizable()
                .scaledToFit()
                .foregroundStyle(themeManager.currentTheme.text)
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
            placeholder
                .resizable()
                .scaledToFit()
                .foregroundStyle(themeManager.currentTheme.text)
        }
    }
    
    
}

extension Image {
    init(safe name: String?, placeholder: Image) {
        if let name, name.isEmpty == false, let uiImage = UIImage(named: name) {
            self = Image(uiImage: uiImage)
        } else {
            self = placeholder
        }
    }
}

#Preview {
    IconView(source: .placeholder)
        .environment(ThemeManager())
}
