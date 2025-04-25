//  PhotoFeed.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import Foundation

struct PhotoFeed: Codable {
    let items: [Photo]
}

struct Photo: Identifiable, Codable, Hashable {
    /// Unique identifier for Identifiable conformance
    var id: String { link.absoluteString }
    let title: String
    let link: URL
    let media: Media
    let description: String
    let author: String
    let published: Date

    /// Nested media object containing the image URL
    struct Media: Codable, Hashable {
        let m: URL
    }
}
