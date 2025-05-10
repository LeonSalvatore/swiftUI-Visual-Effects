//
//  MeshGradientView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct MeshGradientView: View {
    
    @State private var presentConfigurationSheet: Bool = false
    @State private var configuration = MeshGradientConfiguration.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
        
            Toggle("Hide Configuration", isOn: $presentConfigurationSheet.animation())
                .padding(.horizontal)
            
            MeshGradientConfigurationView(configuration: $configuration)
                .verticalAlignment(alignment: .bottom)
                .hide(presentConfigurationSheet)
            
        }
        .verticalAlignment(alignment: .topLeading)
        .navigationTitle("Mesh Gradient")
        .background {
            MeshGradient(
                width: configuration.width,
                height: configuration.height,
                points: configuration.points,
                colors: configuration.colorsWithOpacity)
            .ignoresSafeArea()
            
        }
       
    }
}

public extension Color {
    
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

#Preview {
    NavigationStack {
        MeshGradientView()
    }
}

struct MeshGradientConfigurationView: View {
    
    @Binding var configuration: MeshGradientConfiguration
    
    var body: some View {
        VStack(alignment: .leading) {
            Section("Config Size") {
                
                Picker("Point", selection: $configuration.selectedPointIndex) {
                    ForEach(0..<configuration.points.count, id: \.self) { index in
                        Text("P\(index)")
                            .tag(index)
                            .foregroundColor(.secondary)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background()
                .clipShape(.rect(cornerRadius: 10))
                
                // Sliders for X and Y coordinates of the selected point
                VStack(alignment: .leading) {
                    
                    Text("Edit Point \(configuration.selectedPointIndex)")
                        .font(.caption)
                    
                    HStack {
                        Text("X: \(configuration.points[configuration.selectedPointIndex][0], specifier: "%.2f")")
                            .font(.caption)
                        
                        Slider(value: Binding(
                            get: { configuration.points[configuration.selectedPointIndex][0] },
                            set: { configuration.points[configuration.selectedPointIndex][0] = $0 }
                        ), in: 0...1)
                    }
                    HStack {
                        Text("Y: \(configuration.points[configuration.selectedPointIndex][1], specifier: "%.2f")")
                            .font(.caption)
                        
                        Slider(value: Binding(
                            get: { configuration.points[configuration.selectedPointIndex][1] },
                            set: { configuration.points[configuration.selectedPointIndex][1] = $0 }
                        ), in: 0...1)
                    }
                }
                .padding()
                .background()
                .clipShape(.rect(cornerRadius: 10))
                .foregroundColor(.secondary)
            }
            .foregroundColor(.white)
            
            
            
            Section("Colors") {
                // Sliders for color opacity
                VStack(alignment: .leading) {
                    
                    ColorPicker("Color", selection: $configuration.colors[configuration.selectedPointIndex])
                    Text("Color Opacity for P\(configuration.selectedPointIndex)")
                        
                    Slider(value: $configuration.colorOpacities[configuration.selectedPointIndex], in: 0...1)
                    Text("Opacity: \(configuration.colorOpacities[configuration.selectedPointIndex], specifier: "%.2f")")
                }
                .colorPickerStyle()
            }
            .foregroundColor(.white)
            
        }
        .padding()
        
    }
}

struct MeshGradientConfiguration {
    
    var selectedPointIndex: Int
    var width: Int
    var height: Int
    var colors: [Color]
    var points: [SIMD2<Float>]
    var colorOpacities: [Double]
    
    var colorsWithOpacity: [Color] {
        zip(colors, colorOpacities).map { color, opacity in
            color.opacity(opacity)
        }
    }
    
    static let `default` = Self.init(
        selectedPointIndex: 0,
        width: 3,
        height: 3,
        colors: [
            // Row 1 (Top) - Soft sky/cyan tones
            Color(red: 0.05, green: 0.15, blue: 0.3),  // Deep twilight
            Color(red: 0, green: 0.5, blue: 1),       // Apple Blue
            Color(red: 0.3, green: 0.8, blue: 1),      // Sky light
            
            // Row 2 (Middle) - Vibrant accents
            Color(red: 1, green: 0.2, blue: 0.5),      // Pink
            .white,                                    // Center highlight
            Color(red: 0.1, green: 0.8, blue: 0.6),    // Teal
            
            // Row 3 (Bottom) - Warm base
            Color(red: 0.8, green: 0.1, blue: 0.1),    // Warm red
            Color(red: 1, green: 0.6, blue: 0),        // Orange
            Color(red: 0.9, green: 0.9, blue: 0.1)     // Soft yellow
        ],
        points: [
            [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],      // Top row
            [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],      // Middle
            [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]       // Bottom
        ],
        colorOpacities: [
            // Opacity mapped to Apple's translucent aesthetic:
            0.7, 0.9, 0.6,    // Top row (darker → lighter)
            0.8, 1.0, 0.7,    // Middle (highlight at center)
            0.6, 0.8, 0.5     // Bottom (warm tones with variation)
        ]
    )
    static let coordinate = Self.init(
        selectedPointIndex: 0,
        width: 2,  // 2x2 grid for 4 points
        height: 2,
        colors: [
            // A (1,2) - Deep Indigo
            Color(red: 0.25, green: 0.0, blue: 0.5),
            // B (3,4) - Apple Red
            Color(red: 1.0, green: 0.23, blue: 0.19),
            // C (5,6) - System Teal
            Color(red: 0.35, green: 0.78, blue: 0.93),
            // D (7,8) - Golden Yellow
            Color(red: 1.0, green: 0.8, blue: 0.0)
        ],
        points: [
            // Normalized coordinates (0-1 range)
            [0.0, 0.0],  // A (1,2 → bottom-left)
            [1.0, 0.0],  // B (3,4 → bottom-right)
            [0.0, 1.0],  // C (5,6 → top-left)
            [1.0, 1.0]   // D (7,8 → top-right)
        ],
        colorOpacities: [
            0.9,  // A (rich base)
            0.8,  // B (vibrant accent)
            0.7,  // C (airy highlight)
            0.9   // D (glowing focal point)
        ]
    )
}
