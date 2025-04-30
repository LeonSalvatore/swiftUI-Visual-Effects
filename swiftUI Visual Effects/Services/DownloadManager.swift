//
//  DownloadManager.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

/// An actor that manages download operations for images.
///
/// This actor provides thread-safe image downloading capabilities and should be
/// accessed through its shared instance.
///
/// ## Thread Safety
/// All download operations are automatically serialized and thread-safe
/// due to the actor's nature.
actor DownloadManager {
    /// The shared singleton instance of the DownloadManager.
    static let shared = DownloadManager()
    
    private init() {}
    
    /// Downloads an image from the specified URL asynchronously.
    ///
    /// - Parameter url: The URL string from which to download the image.
    /// - Returns: The downloaded `Image` object.
    /// - Throws: An error if the download fails, including:
    ///   - `APIServiceError.networkError` for invalid URLs or network failures
    ///   - `APIServiceError.decodingError` if the downloaded data isn't a valid image
    ///   - `APIServiceError.customError` for HTTP status code errors
    func downloadImage(url: String) async throws -> UIImage? {
        // 1. Create URL from string
        guard let validURL = URL(string: url) else {
            throw APIServiceError.customError("Invalid URL format")
        }
        
        // 2. Make network request
        let (data, response) = try await URLSession.shared.data(from: validURL)
        
        // 3. Validate response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIServiceError.networkError(NSError(domain: "NetworkError", code: 0))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIServiceError.customError("HTTP Error: \(httpResponse.statusCode)")
        }
        
        // 4. Convert data to Image
        guard let image = UIImage(data: data)
        else { throw APIServiceError.customError("Error decoding image data") }
        
        // 5. Return result
        return image
    }
}
