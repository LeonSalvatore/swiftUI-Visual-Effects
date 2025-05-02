//
//  Stripes.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct Stripes: View {
    
    @State private var config: StripeConfig = .init()
    @State private var color: Color = .red
    
    var body: some View {
        
        VStack {
            
            GroupBox {
                Slider(value: $config.height, in: 0...100)
            }
            .padding(.horizontal)
            
            VStack {
                Rectangle()
                    .stripe(config)
                    .clipShape(.rect(cornerRadius: 10))
                
            }
            .padding()
        }
        .navigationTitle("Stripes")
       
    }
    
}

extension View where Self: Shape {
    
    func stripe(_ config: StripeConfig) -> some View {
        fill(config.fill)
    }
}

struct StripeConfig: Hashable {
    
    var colors: [Color] = [
               Color(red: 0.55, green: 0.0, blue: 0.4),     // Deep magenta
               Color(red: 0.2, green: 0.0, blue: 0.6),       // Indigo
               Color(red: 0.0, green: 0.2, blue: 0.7),       // Midnight blue
               Color(red: 0.9, green: 0.1, blue: 0.1),       // Bright red
               .white,                                       // White
               Color(red: 0.0, green: 0.9, blue: 0.8),       // Bright aqua
               Color(red: 0.0, green: 0.4, blue: 1.0),       // Neon blue
               Color(red: 1.0, green: 0.8, blue: 0.0),       // Warm orange
               Color(red: 1.0, green: 1.0, blue: 0.4)        // Bright yellow
           
    ]
    var height: CGFloat = 15
    
    var fill: Shader {
        ShaderLibrary
            .Stripes(
            .float(height),
            .colorArray(colors)
        )
    }
}

#Preview {
    NavigationStack {
        Stripes()
    }
}
