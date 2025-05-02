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
                LazyHStack {
                    ForEach(samples) { sample in
                        ScrollTransitionalView(sample, axis: .horizontal) { content, phase in
                            content
                                .rotationEffect(.degrees(phase.value * 2.5))
                                .offset(y: phase.isIdentity ? 0 : 8)
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
