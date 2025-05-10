//
//  ParticlesMainView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 06.05.2025.
//

import SwiftUI

struct ParticlesMainView: View {
    
    var body: some View {
        Particles(createSystem())
    }
    
    func createSystem() -> ParticleSystem {
        var system = ParticleSystem()
        return system
    }
}

#Preview {
    ParticlesMainView()
        .environment(\.colorScheme, .dark)
}

// View to Render the particles
struct Particles: View {
    @State private var system: ParticleSystem
    init(_ system: ParticleSystem) {
        _system = .init(wrappedValue: system)
    }
    
    
   var body: some View {
        
       TimelineView(.animation) { timeline in
           Canvas { context, size in
               system.update(date: timeline.date)
               drawParticles(system, into: context, at: size)
           }
       }
    }
    
    func drawParticles(
        _ system: ParticleSystem,
        into context: GraphicsContext,
        at size: CGSize) {
            
            for particle in system.particles {
                let x = particle.position.x * size.width
                let y = particle.position.y * size.height
               
                let image = Image(.circle)
                let position = CGPoint(x: x, y: y)
                context.draw(image, at: position)
            }
    }
            
}

struct Particle {
    // A vector of two scalar values.
    // single instruction multiple data
    // 0 -> top Left position
    // 1 -> Bottom right position
    var position:SIMD2<Double>
    
    /// sleep to make it move
    var speed: SIMD2<Double>
}


class ParticleSystem {
    
    var particles = [Particle]()
    var position:SIMD2<Double> = .init(0.5,0.5)
    var speed:SIMD2<Double> = .init(0.1,0.1)
    var lastUpdateTime = Date.now.timeIntervalSince1970
    
   
   
}

extension ParticleSystem {
    
    func generateParticle() {
        
        let angle = Double.random(in: 0..<2*Double.pi * 2)
        let xSpeed = speed.x * cos(angle)
        let ySpeed = speed.y * sin(angle)
        
        
        let newElement =  Particle(
            position: position,
            speed: [xSpeed,ySpeed])
        
        particles.append(newElement)
        
    }
    
    func update(date: Date) {
        
        generateParticle()
        
       
        
        let currentDate = date.timeIntervalSince1970
        let timeIntervalSinceLastUpdate = currentDate - lastUpdateTime
        lastUpdateTime = currentDate
        
        particles = particles.compactMap {
            var workingCopy = $0
            workingCopy.position += (workingCopy.speed * timeIntervalSinceLastUpdate)
            return workingCopy
        }
        
    }
}

extension Double {
     func spread() -> Self {
        return Self.random(in: -self / 2...self / 2)
    }
}
