//  Photo+Extensions.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import Foundation

extension Photo {
    /// Returns the description with all HTML tags removed
    var plainDescription: String {
        description
            .replacingOccurrences(
                of: "<[^>]+>",
                with: "",
                options: .regularExpression
            )
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Returns the published date formatted as a user-friendly string
    var formattedPublishDate: String {
        Self.dateFormatter.string(from: published)
    }

    /// Shared DateFormatter for formatting the published date
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
