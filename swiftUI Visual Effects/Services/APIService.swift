//
//  APIService.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

/// A service actor that handles API requests and image fetching operations.
///
/// This actor provides thread-safe API operations and manages image downloads
/// through a shared `DownloadManager`. It handles various error cases through
/// the `APIServiceError` enum.
///
/// ## Example
/// ```swift
/// let service = APIService()
/// do {
///     let images = try await service.fetchImages()
///     // Handle fetched images
/// } catch {
///     // Handle errors
/// }
/// ```
actor APIService {
    
    static let shared = APIService()
    
    /// The shared instance of `DownloadManager` used for image downloads.
    private let downloadManager = DownloadManager.shared
    
    /// Fetches images from a remote URL asynchronously.
    /// - Parameters: string URL
    /// - Returns: An optional array of `Image` objects. Returns `nil` if the download fails.
    /// - Throws: `APIServiceError` if any error occurs during the fetch operation.
    ///
    /// ## Discussion
    /// This method currently uses a hardcoded URL for demonstration purposes.
    /// In a production environment, you would typically:
    /// - Use a proper API endpoint
    /// - Handle pagination
    /// - Process multiple images
    
    func fetchImage(from url: String) async throws -> UIImage {
        guard let image = try await downloadManager.downloadImage(url: url) else {
            throw APIServiceError.customError("Failed to create image from downloaded data")
        }
        return image
    }
    
}

/// An enumeration of possible errors that can occur during API service operations.
///
/// This error type provides detailed information about failures in the API service,
/// including network issues, decoding problems, and custom error messages.
enum APIServiceError: Error {
    /// A network-related error occurred.
    /// - Parameter error: The underlying error that caused the failure.
    case networkError(Error)
    
    /// A decoding error occurred when parsing the response.
    /// - Parameter error: The underlying error that caused the parsing failure.
    case decodingError(Error)
    
    /// A custom error with a specific message.
    /// - Parameter message: A descriptive message about the error.
    case customError(String)
}

extension APIServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "Network Error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .customError(let message):
            return message
        }
    }
}

