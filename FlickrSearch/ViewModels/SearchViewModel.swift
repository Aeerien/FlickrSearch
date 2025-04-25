//  SearchViewModel.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var photos: [Photo] = []
    @Published private(set) var isLoading: Bool = false

    private let service: PhotoServiceProtocol
    private var searchTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    /// Initializes with a service conforming to PhotoServiceProtocol
    init(service: PhotoServiceProtocol = FlickrPhotoService()) {
        self.service = service

        // Debounce query changes, then perform search
        $query
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newQuery in
                self?.searchPhotos(with: newQuery)
            }
            .store(in: &cancellables)
    }

    /// Performs the photo search for given tags
    private func searchPhotos(with tags: String) {
        searchTask?.cancel()
        let trimmed = tags.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            photos = []
            return
        }

        isLoading = true
        searchTask = Task {
            defer { isLoading = false }
            do {
                let results = try await service.fetchPhotos(tags: trimmed)
                photos = results
            } catch {
                photos = []
                // TODO: Show error to user
            }
        }
    }
}
