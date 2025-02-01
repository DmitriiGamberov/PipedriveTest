//
//  PersonListViewModel.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 27.01.2025.
//

import Combine
import Foundation

enum ViewState: Equatable {
    case loading
    case loaded
}

@MainActor
final class PersonListViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var persons: [Person] = []
    private(set) var viewState: ViewState = .loading
    @Published private(set) var errorMessage: String?
    @Published var showErrorAlert = false
    @Published var showPlaceholder = false
    private var cursor: Int? = 0
    private var hasMore = true
    
    init() {
        getPersons()
    }
    
    func getPersons(reload: Bool = false) {
        if reload {
            cursor = 0
            hasMore = true
        }
        if !hasMore {
            return
        }
        
        guard let cursor else { return }
        Task {
            viewState = .loading
            
            try await PersonsAPI.shared.getPersons(cursor: cursor) { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    switch result {
                    case .success(let success):
                        persons.append(contentsOf: success.data)
                        showPlaceholder = persons.isEmpty
                        hasMore = success.additionalData.pagination.hasMore
                        self.cursor = success.additionalData.pagination.nextStart
                        viewState = .loaded
                    case .failure(let failure):
                        errorMessage = failure.localizedDescription
                        showErrorAlert = true
                    }
                }

            }
        }
    }
    
    func loadMoreIfNeeded(currentItem: Person) {
        if hasMore && currentItem == persons.last {
            getPersons()
        }
    }
    
    func reload() {
        getPersons(reload: true)
    }
}
