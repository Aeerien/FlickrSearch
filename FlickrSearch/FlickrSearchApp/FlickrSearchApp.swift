//  FlickrSearchApp.swift
//  FlickrSearch
//  Created by Irina Arkhireeva on 25.04.2025.

import SwiftUI

/// The main entry point of the application
@main
struct FlickrSearchApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SearchView(viewModel: SearchViewModel())
            }
        }
    }
}
