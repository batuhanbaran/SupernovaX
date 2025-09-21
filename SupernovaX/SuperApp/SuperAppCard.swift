//
//  SuperAppCard.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 21.09.2025.
//

import SwiftUI

// MARK: - Super App Card
struct SuperAppCard: View {
    let app: SuperApp
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                // App Icon
                ZStack {
                    Circle()
                        .fill(app.color.opacity(0.1))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: app.icon)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(app.color)
                }
                
                // App Info
                VStack(spacing: 4) {
                    Text(app.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .frame(height: 20)
                    
                    Text(app.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(height: 26)
                }
            }
            .frame(width: 150, height: 140)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(SuperAppCardButtonStyle())
    }
}

// MARK: - Custom Button Style
struct SuperAppCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    SuperAppCard(app: SuperApp(
        name: "TodoX",
        icon: "checkmark.circle.fill",
        color: .blue,
        description: "Task Management"
    )) {
        print("Card tapped")
    }
    .padding()
}
