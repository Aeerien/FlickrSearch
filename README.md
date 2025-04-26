# FlickrSearch Test App

This project provides a Swift-based implementation for fetching image data from a remote JSON source, processing and decoding the response into Swift models, and filtering them based on user-entered tags. It is designed with a modular, testable architecture following the Model–View–ViewModel (MVVM) pattern to ensure a clear separation of concerns. The UI is built using SwiftUI for a responsive and intuitive experience. Additionally, the project leverages Swift Concurrency (async/await) for efficient asynchronous operations and follows a protocol-oriented programming approach to enhance flexibility and testability.

## Key Features

- Fetch images data from Flickr’s public feed.  
- Decode the JSON response into Swift models.  
- Filter the list of images based on user-entered tags.  
- Modular architecture with clear separation of concerns.  
- Universal app supporting both iPhone and iPad.  
- Portrait and landscape orientation support.  
- Unit tests for the networking layer and ViewModel.  
- UI tests covering the main user flow.

## App Demo

[![App Demo](https://github.com/user-attachments/assets/45cea55f-d2e3-4201-8321-a15f5ebbfc4c)](https://github.com/user-attachments/assets/45cea55f-d2e3-4201-8321-a15f5ebbfc4c)

## Project Structure

1. **Networking**  
   - `FlickrPhotoService`  
2. **Model**  
   - `PhotoFeed`  
   - `Photo+Extensions`  
3. **ViewModel**  
   - `SearchViewModel`  
4. **Views**  
   - `SearchView`  
   - `DetailView`  
5. **Unit Tests**  
   - `FlickrPhotoServiceTests`  
   - `SearchViewModelTests`  
6. **UI Tests**  
   - `FlickrSearchAppUITests`  
   - `FlickrSearchAppUITestsLaunchTests`

## Requirements

- Xcode 14 or later  
- iOS 15 or later  
- Swift 5.5 or later

## How to Run the App

1. Clone the repository and open `FlickrSearchApp.xcodeproj` in Xcode.  
2. Select the **FlickrSearchApp** scheme and run on the iOS simulator or a physical device.

## How to Run the Tests

1. In Xcode, choose **Product → Test** (⌘ U).  
2. All unit and UI tests will run, and results will be displayed in the Xcode Test navigator.  
