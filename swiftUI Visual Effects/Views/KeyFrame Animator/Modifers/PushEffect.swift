//
//  PushEffect.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 02.05.2025.
//

import SwiftUI

struct PushEffect<T: Equatable>: ViewModifier {
    var trigger: T

    func body(content: Content) -> some View {
        content.keyframeAnimator(
            initialValue: 1.0,
            trigger: trigger
        ) { view, value in
            view.visualEffect { view, _ in
                view.scaleEffect(value)
            }
        } keyframes: { _ in
            SpringKeyframe(0.95, duration: 0.2, spring: .snappy)
            SpringKeyframe(1.0, duration: 0.2, spring: .bouncy)
        }
    }
}
