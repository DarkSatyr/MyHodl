//
//  GlowSeparator.swift
//  MyHodl
//
//  Created by DarkSatyr on 03.02.2026.
//

import SwiftUI

struct GlowSeparator: View {
    var body: some View {
        ZStack {
            // hairline
            FadedSeparator()

            // subtle glow
            FadedSeparator()
                .blur(radius: 6)
                .opacity(0.35)
        }
        .frame(height: 1)
    }
}

#Preview {
    GlowSeparator()
}
