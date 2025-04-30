//
//  ImageManager.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

final class ImageManager {
    
    static let shared = ImageManager()
    
    /// Resizes an image to fit within a given size while maintaining its aspect ratio.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to resize.
    ///   - size: The target `CGSize` for the image.
    /// - Returns: A resized `UIImage`, or `nil` if resizing fails.
     func resizeImage(_ image: UIImage?, size: CGSize) -> UIImage? {
        guard let image else {
            print("\(#function): Failed to resize image. Image is nil.")
            return nil
        }

        let aspectSize = image.size.aspectFit(to: size)

        print("\(#function): Resizing image... Target size: \(size), Aspect size: \(aspectSize), Original size: \(image.size)")

        let renderer = UIGraphicsImageRenderer(size: aspectSize)
        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: aspectSize))
        }

        print("\(#function): Resized image successfully. Aspect size: \(aspectSize), Original size: \(image.size), Resized image: \(resizedImage)")

        return resizedImage
    }
}
