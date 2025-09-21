//
//  TodoXNavigationView.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 21.09.2025.
//

import SwiftUI
import NavigatorUI
import TodoX

// MARK: - TodoX Navigation View
struct TodoXNavigationView: View {
    @Environment(\.navigator) private var navigator
    
    var body: some View {
        TodoXTabView(onClose: {
            navigator.dismiss()
        })
    }
}

#Preview {
    TodoXNavigationView()
}
