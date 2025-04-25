//  SearchView.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel

    /// Adaptive grid layout for thumbnails
    private let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 10)
    ]

    var body: some View {
        VStack {
            // MARK: Search Bar
            TextField("Search tags...", text: $viewModel.query)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            // MARK: Loading Indicator
            if viewModel.isLoading {
                ProgressView()
                    .padding(.vertical, 8)
            }

            // MARK: Photo Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.photos) { photo in
                        // Wrap each thumbnail in a NavigationLink
                        NavigationLink(value: photo) {
                            AsyncImage(url: photo.media.m) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                // Show spinner while thumbnail is loading
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            }
                            .frame(width: 120, height: 120)
                            .clipped()
                            .cornerRadius(8)
                            .accessibilityIdentifier("photoThumbnail_\(photo.id)")
                        }
                    }
                }
                .padding(10)
            }
        }
        .navigationTitle("Flickr Search")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Photo.self) { photo in
            DetailView(photo: photo)
        }
    }
}
