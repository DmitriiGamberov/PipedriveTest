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
        NavigationStack {
            if viewModel.showPlaceholder {
                PersonListPlaceholderView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.persons) { person in
                            NavigationLink(destination: PersonDetailsView(person: person)) {
                                PersonRow(person: person)
                                    .onAppear {
                                        viewModel.loadMoreIfNeeded(currentItem: person)
                                    }
                            }
                        }
                        if viewModel.viewState == .loading {
                            ProgressView()
                                .frame(height: 100)
                        }
                    }
                }
                .refreshable {
                    viewModel.reload()
                }
                .navigationTitle(Text("Persons"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Something went wrong"), dismissButton: .default(Text("Try again"), action: {
                viewModel.getPersons()
            }))
        }
    }
}

#Preview {
    PersonListView()
}
