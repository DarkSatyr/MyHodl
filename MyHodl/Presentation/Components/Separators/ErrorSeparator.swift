//
//  ErrorSeparator.swift
//  MyHodl
//
//  Created by DarkSatyr on 05.02.2026.
//

import SwiftUI

struct ErrorSeparator: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    stops: [
                        .init(color: .red.opacity(0.00), location: 0.00),
                        .init(color: .red.opacity(0.30), location: 0.20),
                        .init(color: .red.opacity(0.30), location: 0.80),
                        .init(color: .red.opacity(0.00), location: 1.00)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 1)
    }
}

#Preview {
    ErrorSeparator()
}
