//
//  PicturesView.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 01.02.2025.
//

import SwiftUI

struct PicturesView: View {
    let urls: [URL]
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
            
            TabView {
                ForEach(urls, id: \.self) { url in
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 250)
                                .cornerRadius(125)
                        } else if phase.error != nil {
                            Image(systemName: "person.circle")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(Color.red)
                                .frame(width: 250, height: 250)
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
            .frame(height: 250)
            .tabViewStyle(.page)
        }
    }
}
