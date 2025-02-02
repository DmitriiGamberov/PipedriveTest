//
//  ViewModifiers.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 01.02.2025.
//

import SwiftUI

// MARK: - General
extension View {
    /// Rounded corners
    func cornerRadius(_ radius: CGFloat) -> some View {
        clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

// MARK: - Style
extension View {
    /// Grouped data style
    func groupedView() -> some View {
        self
            .padding(.all, 16)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(16)
    }
}
