//  PhotoServiceProtocol.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import Foundation

protocol PhotoServiceProtocol {
    func fetchPhotos(tags: String) async throws -> [Photo]
}
