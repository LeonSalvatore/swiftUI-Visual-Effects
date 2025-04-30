//
//  ContentView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    let views = SwiftUIVisualEffects.allCases
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                
                Text(visualEffectBanner)
                
                List {
                    ForEach(views) { view in
                        
                        NavigationLink(view.title, value: view)
                    }
                    .navigationBarTitle("Vissual Effects")
                    
                }
                .listStyle(.inset)
            }
            .padding(.horizontal)
            .verticalAlignment(alignment: .topLeading)
            .navigationDestination(for: SwiftUIVisualEffects.self) { $0.destination() }
        }
    }
    
    var visualEffectBanner: String {
        """
         struct Visual Effets: View {
            var body: some View {
                Text("happy Coding")
            }
        }
        """
    }
}

extension View {
    func verticalAlignment(alignment: Alignment) -> some View {
        
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func horizontalAlignment(alignment: Alignment) -> some View {
        
        frame(maxWidth: .infinity, alignment: alignment)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
