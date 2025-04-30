//
//  ParralaxObserver.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI
import Observation

@Observable
final class ParralaxObserver {
    
    private(set) var images: [Photo] = .init()
    
    var isRemote: Bool = false
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    let apiService: APIService
    
    init(apiService: APIService = .shared) {
        self.apiService = apiService
        self.images = images
    }
    
}
// MARK: Methods

extension ParralaxObserver {
    
    func loadImages() async {
        
        isLoading = true
        images.removeAll(keepingCapacity: true)
        
        if isRemote {
            
            await withThrowingTaskGroup(of: UIImage.self) { group in
                // Add all download tasks
                for photo in Photo.samples {
                    
                    group.addTask {
                        try await self.apiService.fetchImage(from: photo.link)
                    }
                }
                
                // Collect results, ignoring failures
                while let result = await group.nextResult() {
                    if case .success(let image) = result {
                        
                        self.images.append(.init(isRemote: isRemote, image: image))
                        
                        isLoading = false
                        errorMessage = nil
                    } else if case .failure(let failure) = result {
                        print(failure)
                        isLoading = false
                        errorMessage = "Failed to load Remote images"
                        
                    }
                }
            }
        } else {
            images = Photo.staticSamples
            isLoading = false
            errorMessage = nil
        }
    }
}

