//  FlickrPhotoService.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import Foundation

actor FlickrPhotoService: PhotoServiceProtocol {
    private let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne"
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Fetches photos from Flickr feed with given tags
    func fetchPhotos(tags: String) async throws -> [Photo] {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "tags", value: tags)
        ]

        let (data, _) = try await session.data(from: components.url!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let feed = try decoder.decode(PhotoFeed.self, from: data)
        return feed.items
    }
}
