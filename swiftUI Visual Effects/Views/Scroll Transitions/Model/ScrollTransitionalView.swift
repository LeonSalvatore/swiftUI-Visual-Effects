//
//  ScrollTransitionalView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct ScrollTransitionalView<Transition: VisualEffect & Sendable>: View {
    
    let photo: Photo
    let axis: Axis?
    let transition: SendableTransition<Transition>
        
    init(
        _ photo: Photo,
        axis: Axis? = .horizontal,
        transition: @escaping @Sendable (_ content: EmptyVisualEffect, _ phase: ScrollTransitionPhase) -> Transition) {
        
        self.photo = photo
        self.axis = axis
            self.transition = SendableTransition(closure: transition)
    }
    
    var body: some View {
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
            .scrollTransition(axis: axis, transition: transition.closure)
           
        }
        .containerRelativeFrame(.horizontal)
    }
        
}
struct SendableTransition<Transition: VisualEffect & Sendable>: @unchecked Sendable {
    let closure: @Sendable (_ content: EmptyVisualEffect, _ phase: ScrollTransitionPhase) -> Transition
}
