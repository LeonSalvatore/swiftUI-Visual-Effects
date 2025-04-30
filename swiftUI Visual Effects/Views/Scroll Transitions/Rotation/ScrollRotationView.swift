//
//  ScrollRotationView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct ScrollRotationView: View {
    
    let samples = Photo.staticSamples
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(samples) { sample in
                        ScrollTransitionalView(sample, axis: .horizontal) { content, phase in
                            content
                                .rotationEffect(.degrees(phase.value * 1.5))
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(20)
            .scrollTargetBehavior(.paging)
        }
        .navigationTitle("Scroll Rotation View")
    }
 
}



#Preview {
    ScrollRotationView()
}
