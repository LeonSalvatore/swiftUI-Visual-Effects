//
//  ScrollPagingView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct ScrollPagingView: View {
    
    let samples = Photo.staticSamples
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(samples, content: ItemPhoto)
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(20)
            .scrollTargetBehavior(.paging)
        }
        .navigationTitle("Scroll Rotation View")
    }
    
    private func ItemPhoto(_ photo: Photo) -> some View {
        VStack(alignment: .leading) {
            Text(photo.title)
                .font(.title3)
                .foregroundColor(.primary)
            
            Text(photo.photographer ?? "")
                .font(.caption2)
                .fontWeight(.medium)
            
            ResizedImage(photo.image, targetSize: .iPhoneStandard) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            .clipShape(.rect(cornerRadius: 36))
           
        }
        .containerRelativeFrame(.horizontal)
    }
}

#Preview {
    ScrollPagingView()
}
