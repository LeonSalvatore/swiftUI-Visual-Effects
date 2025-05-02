//
//  RippleView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 02.05.2025.
//

import SwiftUI

struct RippleView: View {
    
    let sample = Photo.staticSamples[2]
    
    @State var tap: Int = 0
    @State var presentConfiguration: Bool = false
    
    @State var configuration: RippleConfiguration = .init()
        
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            
            Toggle("Show Configuration", isOn: $presentConfiguration.animation())
            
            ConfigurationView()
                .hide(!presentConfiguration)
            
            
            if let image = sample.image {
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .onPress(processPressGesture)
                    .ripple(config: $configuration, trigger: tap)

            }
            
           
            
        }
        .padding(.horizontal)
        .navigationTitle("Ripple View")
    }
    
    
    private func ConfigurationView() -> some View {
        
        GroupBox(label: Text("Configurations")) {
            
            Grid {
                GridRow {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Time")
                        Slider(value: $configuration.time, in: 0 ... 2)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Amplitude")
                        Slider(value: $configuration.amplitude, in: 0 ... 100)
                    }
                }
                GridRow {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Frequency")
                        Slider(value: $configuration.frequency, in: 0 ... 30)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Decay")
                        Slider(value: $configuration.decay, in: 0 ... 20)
                           
                    }
                }
                
                Text("Reset")
                    .onTapGesture {configuration.reset()}
            }
            .font(.subheadline)
        }
    }
    
    private func processPressGesture(_ coordinates: CGPoint?) {
        if let coordinates {
                configuration.origin = coordinates
                tap += 1
        }
    }
}



struct RippleEffect<T: Equatable>: ViewModifier {
    
    @Binding var config: RippleConfiguration
    var trigger: T
    
    init(config: Binding<RippleConfiguration>, trigger: T) {
        self._config = config
        self.trigger = trigger
    }
    
    func body(content: Content) -> some View {
        
        let duration = config.duration
        let config = config
        
        content
            .keyframeAnimator(initialValue: 0, trigger: trigger) { view, elapsedTime in
                view
                    .modifier(
                        RippleModifier(config: config, elapsedTime: elapsedTime)
                    )
                
            } keyframes: { _ in
                MoveKeyframe(0)
                LinearKeyframe(duration, duration: duration)
            }
        
    }
    
}


struct RippleModifier: ViewModifier {
    
    var config: RippleConfiguration
    var elapsedTime: TimeInterval

    func body(content: Content) -> some View {
        let shader = ShaderLibrary.Ripple(
            .float2(config.origin),
            .float(elapsedTime),

            // Parameters
            .float(config.amplitude),
            .float(config.frequency),
            .float(config.decay),
            .float(config.speed)
        )

        let maxSampleOffset = maxSampleOffset
        let elapsedTime = elapsedTime
        let duration = config.duration

        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: 0 < elapsedTime && elapsedTime < duration
            )
        }
    }

    var maxSampleOffset: CGSize {
        CGSize(width: config.amplitude, height: config.amplitude)
    }
}


#Preview {
    NavigationStack {
        RippleView()
    }
}
