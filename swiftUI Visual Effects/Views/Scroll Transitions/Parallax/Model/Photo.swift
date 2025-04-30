//
//  Photo.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 30.04.2025.
//

import SwiftUI

struct Photo: Identifiable {
    
    var title: String
    var link: String
    var id: UUID = .init()
    var isRemote: Bool
    var photographer: String? = nil
    var image: UIImage?
  
 
    init(title: String = "", link: String = "", photographer: String? = nil, isRemote: Bool = false, image: UIImage? = nil) {
        self.title = title
        self.link = link
        self.isRemote = isRemote
        if isRemote {
            self.image = image
        } else {
            self.image = .init(named: link)
        }
    }

    static var samples: [Self] = [
           .init(
               title: "Mountain Landscape",
               link: "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
               photographer: "Joe Smith",
               isRemote: true
           ),
           .init(
               title: "City Skyline",
               link: "https://images.unsplash.com/photo-1477959858617-67f85cf4f1df",
               photographer: "Jane Doe",
               isRemote: true
           ),
           .init(
               title: "Ocean Waves",
               link: "https://images.unsplash.com/photo-1519046904884-53103b34b206",
               photographer: "John Ocean",
               isRemote: true
           ),
           .init(
               title: "Forest Trail",
               link: "https://images.unsplash.com/photo-1448375240586-882707db888b",
               photographer: "Alice Forest",
               isRemote: true
           ),
           .init(
               title: "Desert Sunset",
               link: "https://images.unsplash.com/photo-1518604666860-9ed391f76460",
               photographer: "Bob Desert",
               isRemote: true
           )
       ]
    
    static var staticSamples: [Self] = [
        .init(title:"Emilia", link: "emilia"),
        .init(title:"Jay", link: "jay"),
        .init(title:"Kevin Charit", link: "kevin-charit"),
        .init(title:"Kiril Krsteski", link: "kiril-krsteski"),
        .init(title:"Strvnge films", link: "strvnge-films"),
        .init(title:"Sumup", link: "sumup")
    ]
}


enum ImageError: Error, LocalizedError {
    case imageNotFound
    
    var description: String {
        switch self {
        case .imageNotFound:
            return "Image not found"
        }
    }
}
