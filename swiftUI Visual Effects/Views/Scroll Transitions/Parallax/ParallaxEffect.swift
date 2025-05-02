//
//  ParallaxEffect.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
/// www.elioene.fr/blog

import SwiftUI
import EazySwiftUI

struct ParallaxEffect: View {
    
   @State private var observer = ParralaxObserver()
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Toggle("Remote Images", isOn: $observer.isRemote)
                .padding(.horizontal)
            
            if observer.isLoading {
                ProgressView()
                    .verticalAlignment(alignment: .center)
                    .horizontalAlignment(alignment: .center)
            } else {
                if let errorMessage = observer.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
               
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(observer.images, content: ItemImage)
                        }
                        
                    }
                    .scrollTargetBehavior(.paging)
                    .contentMargins(20)
                    .scrollIndicators(.hidden)
                    .task {
                        await observer.loadImages()
                    }
               
            }
          
        }
        .navigationTitle("Parallax Effect")
        .verticalAlignment(alignment: .topLeading)
        .onChange(of: observer.isRemote) { _, newValue in
            Task {
                await observer.loadImages()
            }
        }
    }
}

extension ParallaxEffect {
   
    func ItemImage(_ photo: Photo) -> some View {
        
        VStack(alignment: .leading) {
            
            Text(photo.title)
                .font(.title3)
                .foregroundColor(.primary)
            
            Text(photo.photographer ?? "")
                .font(.caption2)
                .fontWeight(.medium)
            
            ZStack {
                ResizedImage(photo.image, targetSize: .iPhoneStandard){ resizedImage in
                    resizedImage
                        .resizable()
                        .scaledToFit()
                    
                }
               
                .scrollTransition(axis: .horizontal) { content, phase in
                    content
                        .offset(x: phase.isIdentity ? 0 : phase.value * -200)
                }
            }
            .containerRelativeFrame(.horizontal)
            .clipShape(.rect(cornerRadius: 36))
            
        }
        
    }
}

#Preview {
    NavigationStack {
        ParallaxEffect()
    }
}
