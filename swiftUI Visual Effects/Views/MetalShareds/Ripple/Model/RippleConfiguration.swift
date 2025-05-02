//
//  RippleConfiguration.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 02.05.2025.
//

import SwiftUI

struct RippleConfiguration: Identifiable {
    
    var origin: CGPoint
    var time: TimeInterval
    var amplitude: TimeInterval
    var frequency: TimeInterval
    var decay: TimeInterval
    var speed: Double
    var duration: TimeInterval { 3 }
    var id: UUID = UUID()
    
    init(origin: CGPoint = .zero,
         time: TimeInterval = 0.3,
         amplitude: TimeInterval = 12,
         frequency: TimeInterval = 15,
         decay: TimeInterval = 8,
         speed: Double = 1200) {
        
        self.origin = origin
        self.time = time
        self.amplitude = amplitude
        self.frequency = frequency
        self.speed = speed
        self.decay = decay
    }
    
    mutating func reset() {
        self = .init(
            origin: .zero,
            time: 0.3,
            amplitude:  12,
            frequency:  15,
            decay: 8,
            speed: 1200
        )
    }
    
}
