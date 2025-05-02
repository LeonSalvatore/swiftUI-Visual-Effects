//
//  ContentView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    let views = SwiftUIVisualEffects.allCases
    

    
    @State private var snapshot: UIImage? = nil
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                
                List {
                    ForEach(views) { view in
                        NavigationLink(value: view) {
                            Text(view.title)
                                .font(.headline)
                           
                        }
                       
                    }
                    .navigationBarTitle("Vissual Effects")
                    
                    
                }
                .listStyle(.inset)
                
            }
            .padding(.horizontal)
            .verticalAlignment(alignment: .topLeading)
            .navigationDestination(for: SwiftUIVisualEffects.self) { $0.destination() }
        }
    }
    
}

// Step 1: Create a cache wrapper
class SnapshotCache {
    static let shared = SnapshotCache()
    private var cache = NSCache<NSString, UIImage>()
    
    func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func set(_ image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

// Step 2: Modified snapshot function
extension View {
    func cachedSnapshot(id: String) -> UIImage? {
        if let cached = SnapshotCache.shared.get(key: id) {
            return cached
        }
        
        guard let image = self.snapshot() else {
            print("Error capturing snapshot")
            return nil
        }
        SnapshotCache.shared.set(image, key: id)
        return image
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
