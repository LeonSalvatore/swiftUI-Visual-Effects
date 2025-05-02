//
//  VisualEffectsView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

#Preview {
    NavigationStack {
        GlobalView(title: "Visual Effects", section: VisualEffects.self)
    }
}

struct GlobalView<T: NavigationProtocol>: View where T: CaseIterable {
    let title: String
    let data: [T]
    
    init(title: String, section: T.Type) {
        self.title = title
        self.data = Array(section.allCases)
    }
    
    var body: some View {
        List(data) { item in
            NavigationLink(value: item) {
                Text(item.title)
            }
        }
        .navigationDestination(for: T.self, destination: \.destination)
        .navigationTitle(title)
    }
}


protocol NavigationProtocol: Hashable, Identifiable, CaseIterable {
    associatedtype Destination: View
    var id: Self { get }
    var destination: Destination { get }
    var title: String { get }
}
