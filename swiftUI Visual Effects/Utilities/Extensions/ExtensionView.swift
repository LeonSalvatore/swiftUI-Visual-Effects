//
//  ExtensionView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 02.05.2025.
//

import SwiftUI

extension View {
    
    
    /// Captures a snapshot of the SwiftUI view as a UIImage
    func snapshot() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    
    func verticalAlignment(alignment: Alignment) -> some View {
        
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func horizontalAlignment(alignment: Alignment) -> some View {
        
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
     func ripple(config: Binding<RippleConfiguration>, trigger: some Equatable)-> some View {
         modifier(RippleEffect(config: config, trigger: trigger))
    }
    
    
    @ViewBuilder
    func pushEffect(trigger: some Equatable)-> some View {
        modifier(PushEffect(trigger: trigger))
    }
        
    
    func onPress(_ action: @escaping (CGPoint?) -> Void) -> some View {
        modifier(SpatialPressingGestureModifier(action: action))
    }
    
    @ViewBuilder
    func hide(_ reason: Bool) -> some View {
        if reason { EmptyView() }
        else { self }
    }
}
