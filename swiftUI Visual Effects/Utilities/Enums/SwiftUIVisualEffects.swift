//
//  SwiftUIVisualEffects.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

enum SwiftUIVisualEffects: String, NavigationProtocol {
    
    case textTransition
    case gradiants
    case visualEffects
    case scrollTransition
    case metal
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .textTransition: return "Text Transition"
        case .visualEffects: return "Visual Effect "
        case .scrollTransition: return "Scroll Transition"
        case .gradiants: return "Mesh Gradient"
        case .metal: return "Metal"
            
        }
    }
    
    var destination: some View {
        Group {
            switch self {
            case .visualEffects:
                GlobalView(title: title, section: VisualEffects.self)
            case .textTransition:
                GlobalView(title: title, section: TextTransitions.self)
            case .gradiants:
                GlobalView(title: title, section: Gradiants.self)
            case .scrollTransition:
                GlobalView(title: title, section: ScrollTransition.self)
            case .metal:
                GlobalView(title: title, section: MetalShaders.self)
            }
        }
    }
    
    
    var snapshot: UIImage? {
        return destination.cachedSnapshot(id: self.rawValue)
    }
}

enum ScrollTransition: NavigationProtocol {
    
    var id: Self { self }
    
    case parallax
    case rotation
    case paging
    
    var title: String {
        switch self {
        case .parallax: "Parallax"
        case .rotation: "Rotation"
        case .paging: "Paging"
        }
    }
    
    var destination: some View {
        Group {
            switch self {
            case .parallax: ParallaxEffect()
            case .rotation: ScrollRotationView()
            case .paging: ScrollPagingView()
            }
        }
    }
    
}
enum VisualEffects: NavigationProtocol {
    
    var id: Self { self }
    case hue
    var title: String {
        switch self {
        case .hue: "Hue Visual Effect"
        }
    }
    
    var destination: some View {
        switch self {
        case .hue: HueVisualEffectView()
        }
    }
    
}
enum MetalShaders: NavigationProtocol {
    
    var id: Self { self }
    
    case ripple
    case stripes
    
    var title: String {
        switch self {
        case .ripple: "Ripple Effect"
        case .stripes: "Stripes"
            
        }
    }
    
    var destination: some View {
        
        switch self {
        case .ripple: AnyView(RippleView())
        case .stripes: AnyView(Stripes())
        }
    }
}
enum TextTransitions: NavigationProtocol {
    
    var id: Self { self }
    
    case fade
    case scale
    case opacity
    case scaleAndFade
    
    var destination: some View {
        TextTransitionView()
    }
    var title: String {
        switch self {
        case .fade: "Fade"
        case .scale: "Scale"
        case .opacity: "Opacity"
        case .scaleAndFade: "Scale and Fade"
        }
    }
}
enum Gradiants: NavigationProtocol {
    var id: Self { self }
    
    case linear
    case radial
    case mesh
    
    var destination: some View {
        MeshGradientView()
    }
    var title: String {
        switch self {
        case .linear: "Linear"
        case .radial: "Radial"
        case .mesh: "Mesh Gradiant"
        }
    }
}

