//
//  GradientPillButton.swift
//  MyHodl
//
//  Created by DarkSatyr on 03.02.2026.
//

import SwiftUI

struct GradientPillButton: View {
    let title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold, design: .default))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
        }
        .buttonStyle(GradientPillStyle())
    }
}

struct GradientPillStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.18, green: 0.95, blue: 0.35), // green
                        Color(red: 0.14, green: 0.72, blue: 0.87), // cyan
                        Color(red: 0.35, green: 0.33, blue: 0.96)  // purple/blue
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: .black.opacity(0.35), radius: 18, x: 0, y: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.10), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.985 : 1.0)
            .opacity(configuration.isPressed ? 0.92 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

#Preview {
    GradientPillButton(title: "Button") {
        
    }
}
