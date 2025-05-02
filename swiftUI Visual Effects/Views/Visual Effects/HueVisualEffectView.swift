//
//  HueVisualEffectView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 02.05.2025.
//

import SwiftUI

struct HueVisualEffectView: View {
    
    enum ShapeType: String,Identifiable, CaseIterable {
        case rect
        case circle
        
        var id: Self { self }
    }
    
    @State private var isOn = false
    @State private var color: Color = .red
    @State private var shapeType: ShapeType = .rect
    @State var position: CGFloat = .zero
    
    let minSize: CGFloat = 10
    let maxSize: CGFloat = 80
    
    let range: Range<Int> = 0..<20
    
    var body: some View {
        VStack {
            
            Picker("Shape Style", selection: $shapeType) {
                ForEach(ShapeType.allCases) { shape in
                    Text(shape.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Toggle("Scale Effect", isOn: $isOn)
                .padding(.horizontal)
            
            Group {
                if shapeType == .circle {
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(range, id: \.self) { _ in
                                CircleView(color: color)
                            }
                        }
                    }
                    
                } else  {
                    ScrollView {
                        ForEach(range, id: \.self) { _ in
                            RoundedRectangleView(color: color, isOn: isOn)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(15)
            .navigationTitle("Hue Visual Effect")
        }
        .verticalAlignment(alignment: .topLeading)
        .overlay(alignment: .bottomTrailing) {
            
            Circle()
                .fill(.ultraThinMaterial)
                .frame(height: 50)
                .overlay(alignment: .center) {
                    ColorPicker("", selection: $color)
                        .labelsHidden()
                        .padding()
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                .verticalAlignment(alignment: .bottom)
            
        }
    }
    
    
    private func RoundedRectangleView(color: Color, isOn: Bool) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(color)
            .frame(height: 100)
            
            .visualEffect { content, proxy in
                let frame = proxy.frame(in: .scrollView(axis: .vertical))
                
                let distance = min(0, frame.minY)
                
                return content
                    .hueRotation(.degrees(frame.origin.y / 10))
                    .scaleEffect( isOn ? (1 + distance / 700) : 1)
                    .offset(y:isOn ? (-distance / 1.25) : .zero)
                    .brightness(isOn ? (-distance / 400) : .zero)
                    .blur(radius:isOn ? (-distance / 50) : .zero)
            }
        
    }
    
    private func CircleView(color: Color) -> some View {
        Circle()
            .fill(color)
            .frame(width: 50, height: 50)
            .visualEffect { effect, proxy in
                let frame = proxy.frame(in: .scrollView(axis: .horizontal))
                return effect
                    .hueRotation(.degrees(frame.origin.x / 10))
                    
            }
    }
            
}

#Preview {
    NavigationStack {
        HueVisualEffectView()
    }
}
