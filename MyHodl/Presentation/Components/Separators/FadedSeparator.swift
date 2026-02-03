//
//  FadedSeparator.swift
//  MyHodl
//
//  Created by DarkSatyr on 03.02.2026.
//

import SwiftUI

struct FadedSeparator: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    stops: [
                        .init(color: .white.opacity(0.00), location: 0.00),
                        .init(color: .white.opacity(0.10), location: 0.20),
                        .init(color: .white.opacity(0.10), location: 0.80),
                        .init(color: .white.opacity(0.00), location: 1.00)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 1)
    }
}

#Preview {
    FadedSeparator()
}
