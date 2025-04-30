//
//  SwiftUIVisualEffects.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

enum SwiftUIVisualEffects: String,Identifiable, CaseIterable, Hashable {
    case textTransition
    case stripes
    case meshGradient
    case visualEffects
    case scrollTransition
        
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .textTransition: return "Text Transition"
        case .stripes: return "Stripes"
        case .visualEffects: return "Visual Effect "
        case .scrollTransition: return "Scroll Transition"
        case .meshGradient: return "Mesh Gradient"
            
        }
    }
    
    @ViewBuilder
    func destination() -> some View {
        switch self {
        case .textTransition:
            TextTransitionView()
        case .stripes:
            Stripes()
        case .visualEffects:
        VisualEffectsView()
        case .scrollTransition:
            ScrollTransitionView()
        case .meshGradient:
            MeshGradientView()
        }
    }
}

enum ScrollTransition: String, Identifiable, CaseIterable, Hashable {
    
    var id: Self { self }
    case parallax
    case rotation
    case paging
    
    @ViewBuilder
    func destination()-> some View {
        switch self {
        case .parallax: ParallaxEffect()
            case .rotation: ScrollRotationView()
        case .paging: ScrollPagingView()
        }
    }
    
}

enum VisualEffects: String, Identifiable, CaseIterable, Hashable {
    var id: Self { self }
    case ugh
    var title: String { rawValue.capitalized }
    
}
