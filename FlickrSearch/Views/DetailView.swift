//  DetailView.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import SwiftUI

struct DetailView: View {
    let photo: Photo

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: Image
                AsyncImage(url: photo.media.m) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: UIScreen.main.bounds.height / 2
                )
                .clipped()

                // MARK: Title
                Text(photo.title)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier("detailTitle")

                // MARK: Description
                Text(photo.plainDescription)
                    .font(.body)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .accessibilityIdentifier("detailDescription")

                // MARK: Author
                Text(photo.author)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier("detailAuthor")

                // MARK: Published Date
                Text(photo.formattedPublishDate)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier("detailPublishDate")
            }
            .padding(.top)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
