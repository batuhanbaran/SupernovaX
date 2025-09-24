//
//  SuperAppSheet.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 21.09.2025.
//

import SwiftUI
import NavigatorUI

// MARK: - Super App Sheet
struct SuperAppSheet: View {
    @Environment(\.navigator) private var navigator
    
    private let apps: [SuperApp] = [
        SuperApp(
            name: "TodoX",
            icon: "checkmark.circle.fill",
            color: .blue,
            description: "Task Management"
        ),
        SuperApp(
            name: "Coming Soon",
            icon: "plus.circle.fill",
            color: .gray,
            description: "More apps"
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                headerSection
                
                // Apps Grid
                appsGridSection
                
                // Bottom padding for natural spacing
                Color.clear.frame(height: 40)
            }
            .background(Color(.systemGroupedBackground))
            .presentationDetents([.height(intrinsicHeight)])
            .presentationDragIndicator(.visible)
            .presentationContentInteraction(.scrolls)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        navigator.dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
    
    // MARK: - Intrinsic Height Calculation
    private var intrinsicHeight: CGFloat {
        let headerHeight: CGFloat = 72      // Header section height (20+24+28 padding + text)
        let cardHeight: CGFloat = 140       // Each card height (fixed)
        let cardSpacing: CGFloat = 16       // Grid spacing between rows
        let topPadding: CGFloat = 20        // Header top padding
        let bottomPadding: CGFloat = 40     // Bottom spacing
        let toolbarHeight: CGFloat = 44     // Navigation toolbar
        let _: CGFloat = 40 // Grid horizontal padding (20*2)
        
        // Calculate number of rows needed (2 columns)
        let numberOfRows = ceil(Double(apps.count) / 2.0)
        
        // Calculate grid height: (rows * card height) + (spacing between rows)
        let gridHeight = (cardHeight * numberOfRows) + (cardSpacing * max(0, numberOfRows - 1))
        
        // Total height calculation
        let totalHeight = toolbarHeight + topPadding + headerHeight + gridHeight + bottomPadding
        
        return totalHeight
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("SupernovaX")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Choose an app to continue")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 20)
        .padding(.bottom, 24)
    }
    
    // MARK: - Apps Grid Section
    private var appsGridSection: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(150)),
            GridItem(.fixed(150))
        ], spacing: 16) {
            ForEach(apps) { app in
                SuperAppCard(app: app) {
                    handleAppSelection(app)
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - App Selection Handler
    private func handleAppSelection(_ app: SuperApp) {
        switch app.name {
        case "TodoX":
            navigator.navigateTodoX()
        default:
            navigator.dismiss()
        }
    }
}

#Preview {
    SuperAppSheet()
}
