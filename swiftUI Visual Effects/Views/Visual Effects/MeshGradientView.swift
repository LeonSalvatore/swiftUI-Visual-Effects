//
//  MeshGradientView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct MeshGradientView: View {
  
    var body: some View {
        VStack {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.8, 0.2], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ], colors: [
                    Color.black, .black, .black,
                    .orange, .blue, .purple,
                    .green, .green, .yellow
                ])
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Mesh Gradient")
        .tint(.white)
    }
}

#Preview {
    MeshGradientView()
}
