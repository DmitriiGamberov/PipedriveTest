//
//  PersonListView.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 27.01.2025.
//

import SwiftUI

struct PersonListView: View {
    @ObservedObject private var viewModel = PersonListViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.showPlaceholder {
                PersonListPlaceholderView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.persons) { person in
                            NavigationLink(destination: PersonDetailsView(person: person)) {
                                PersonRow(person: person)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Persons")
    }
}

#Preview {
    PersonListView()
}
