//
//  CartButton.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 15.09.2025.
//

import SwiftUI

// MARK: - Cart Button Component
public struct CartButton: View {
    public let productId: String
    public var onTap: (() -> Void)? = nil

    @State private var isPressed = false
    @State private var isInCart = false
    @State private var bounceAnimation = false
    @State private var pulseAnimation = false

    public init(productId: String, isInCart: Bool = false, onTap: (() -> Void)? = nil) {
        self.productId = productId
        self._isInCart = State(initialValue: isInCart)
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: handleTap) {
            ZStack {
                // Background circle
                Circle()
                    .fill(backgroundColor)
                    .frame(width: 36, height: 36)
                    .shadow(
                        color: shadowColor.opacity(0.3),
                        radius: isPressed ? 2 : 4,
                        x: 0,
                        y: isPressed ? 1 : 2
                    )
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .scaleEffect(bounceAnimation ? 1.2 : 1.0)

                // Pulse effect for add to cart
                if pulseAnimation {
                    Circle()
                        .stroke(Color.accentColor.opacity(0.5), lineWidth: 2)
                        .frame(width: 36, height: 36)
                        .scaleEffect(pulseAnimation ? 2.0 : 1.0)
                        .opacity(pulseAnimation ? 0.0 : 1.0)
                }

                // Cart icon
                Image(systemName: iconName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(iconColor)
                    .scaleEffect(bounceAnimation ? 1.1 : 1.0)
                    .rotationEffect(.degrees(bounceAnimation ? 10 : 0))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: .infinity,
            perform: {},
            onPressingChanged: { pressing in
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = pressing
                }
            }
        )
    }

    // MARK: - Private Methods
    private func handleTap() {
        // Toggle cart state
        isInCart.toggle()

        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()

        // Bounce animation
        withAnimation(.interpolatingSpring(stiffness: 500, damping: 10)) {
            bounceAnimation = true
        }

        // Pulse animation for add to cart
        if isInCart {
            withAnimation(.easeOut(duration: 0.6)) {
                pulseAnimation = true
            }
        }

        // Reset animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.2)) {
                bounceAnimation = false
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            pulseAnimation = false
        }

        // Call external handler
        onTap?()
    }

    // MARK: - Computed Properties
    private var backgroundColor: Color {
        if isInCart {
            return Color.accentColor
        } else {
            return Color(UIColor.secondarySystemBackground)
        }
    }

    private var iconColor: Color {
        if isInCart {
            return .white
        } else {
            return Color.primary
        }
    }

    private var shadowColor: Color {
        if isInCart {
            return Color.accentColor
        } else {
            return Color.black
        }
    }

    private var iconName: String {
        if isInCart {
            return "cart.fill"
        } else {
            return "cart.badge.plus"
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 20) {
            CartButton(productId: "1", isInCart: false)
            CartButton(productId: "2", isInCart: true)
        }

        // Demo in card context
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .frame(width: 200, height: 120)
                .shadow(radius: 4)

            CartButton(productId: "demo") {
                print("Cart button tapped!")
            }
            .padding(12)
        }
    }
    .padding()
}
