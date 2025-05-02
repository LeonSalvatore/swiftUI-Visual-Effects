//
//  ScrollTransitionView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct ScrollTransitionView: View {
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            List {
                ForEach(ScrollTransition.allCases, content: Content)
            }
            
        }
        .verticalAlignment(alignment: .topLeading)
        .navigationTitle("Scroll Transitions")
        .navigationDestination(for: ScrollTransition.self, destination:( {$0.destination()}))
    }
    
    @ViewBuilder
    private func Content(_ transition: ScrollTransition)-> some View {
        NavigationLink(transition.rawValue.capitalized, value: transition)
    }
}

#Preview {
    NavigationStack {
        ScrollTransitionView()
    }
}
