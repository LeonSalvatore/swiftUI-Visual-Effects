//
//  VisualEffectsView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct VisualEffectsView: View {
    
    var body: some View {
        VStack {
            List{
                ForEach(VisualEffects.allCases) { effect in
                    NavigationLink(effect.title, value: effect)
                }
            }
        }
        .navigationTitle("Visual Effects")
        .navigationDestination(for: VisualEffects.self, destination: {$0.destination()})
    }
}

#Preview {
    NavigationStack {
        VisualEffectsView()
    }
}
