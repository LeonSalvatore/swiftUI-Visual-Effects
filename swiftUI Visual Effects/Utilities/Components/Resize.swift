//
//  ResizedImage.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

 struct ResizedImage<T:View>: View {

   let image: UIImage?
   var targetSize: CGSize
   @ViewBuilder var content: (Image) -> T

   @State private var resizedImage: Image?

   public init(_ image: UIImage?, targetSize: CGSize, content: @escaping (Image) -> T) {
       self.image = image
       self.targetSize = targetSize
       self.content = content
   }

    public var body: some View {

        ZStack {
            if let resizedImage {
                content(resizedImage)
            } else {
                ProgressView()
            }
        }
        .task {
            if let image {
                generateResizedImage(from: image)
            }
        }
        .onChange(of: image) {  oldImage ,image in
            if let image, let oldImage, oldImage != image {
                generateResizedImage(from: image)
            }
        }
    }

      /**
       Resizes the given image to the target size and updates `resizedImage`.

       - Parameter img: The `UIImage` to resize.
       - Recommended sizes: 1080x1080 px, 320x320 px, minimum 240x240 px.
       */
      private func generateResizedImage(from img: UIImage) {

          Task(priority: .background) {
              if let result = ImageManager.shared.resizeImage(img, size: targetSize) {
                  await MainActor.run {
                      resizedImage = Image(uiImage: result)
                  }
              } else {
                  print("From \(#function) - Image not resized")
              }
          }
      }
}
