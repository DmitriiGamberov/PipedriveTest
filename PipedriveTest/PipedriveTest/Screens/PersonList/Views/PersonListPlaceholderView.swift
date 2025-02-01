//
//  PersonListPlaceholderView.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 27.01.2025.
//

import SwiftUI

struct PersonListPlaceholderView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: "person.slash")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Seems like your person list is empty")
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    PersonListPlaceholderView()
}
