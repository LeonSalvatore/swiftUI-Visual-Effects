//
//  TextHighlightView.swift
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 06.05.2025.
//

import SwiftUI

struct TextHighlightView: View {
    
    @State private var isHighlighted: Bool = false
    @State private var text: String = "Elione Leon Salvatore"
    @State private var highlight: String = ""
    @State private var highlightColor: Color = .cyan
    
    var highLightedWord: [String] {
        text.components(separatedBy: .whitespaces)
    }
    
    var columns: [GridItem] {
        Array(repeating: GridItem(.adaptive(minimum: 100)), count: 3)
    }
    
    var body: some View {
        VStack {
            
            Section("Highlight") {
                
                Text(text)
                    .font(.title2)
                    .foregroundStyle(.black)
                //                .hightLight(text: highlight)
                    .customAttribute(HighLight(text: highlight))
                    .textRenderer(HighLightRenderer(color: highlightColor))
                
                TextField("Enter Text", text: $text, prompt: Text("Type here..."))
                    .font(.callout)
                    .textFieldStyle(.default)
                    .padding(.vertical)
            }
            .foregroundColor(.secondary)
            .horizontalAlignment(alignment: .leading)
            .font(.headline.monospacedDigit().lowercaseSmallCaps())
            
            
            Section("Selected word to be hightlighted") {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                    ForEach(highLightedWord, id: \.self) { word  in
                        Text(word)
                            .padding()
                            .horizontalAlignment(alignment: .center)
                            .background(.gray.tertiary, in: .rect(cornerRadius: 15))
                            .onTapGesture {
                                withAnimation {
                                    self.highlight = (highlight == word) ? "" : word
                                    isHighlighted = (highlight == word)
                                }
                            }
                            .foregroundStyle(highlight == word ? .blue : .primary)
                            .visualEffect { content, proxy in
                                
                                let hightLightText = highlight
                                
                                return content
                                    .scaleEffect(hightLightText == word ? 1.1 : 0.9)
                            }
                    }
                }
            }
            .foregroundColor(.secondary)
            .font(.headline.monospacedDigit().lowercaseSmallCaps())
            .horizontalAlignment(alignment: .leading)
            
            
            
        }
        .padding(.horizontal)
        .verticalAlignment(alignment: .topLeading)
        .navigationTitle("Text Highlight View")
        .overlay(alignment: .bottomTrailing) {
            ColorPicker("Color", selection: $highlightColor)
                .labelsHidden()
                .padding()
                .shadow(radius: 5)
        }
    }
}
extension View {
    func colorPickerStyle() -> some View {
        foregroundColor(.secondary)
            .padding()
            .font(.caption)
            .background(.background)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View where Self == Text {
    
    func hightLight(text: String) -> some View {
        self
        //        modifier(TextHighlightModifer(text: text))
        //        textRenderer(TextHighAttribute(text: Text.Layout.Run)
    }
}

struct TextHighlightModifer: ViewModifier {
    let text: String
    func body(content: Content) -> some View {
        
    }
}

extension TextFieldStyle where Self == CommonTextFieldStyle {
    
    static var `default`: Self { CommonTextFieldStyle()}
}

struct CommonTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .body
            .padding(8)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
        
    }
    
}
struct HighLight: TextAttribute {
    let text: String
}
struct HighLightRenderer: TextRenderer {
    var color: Color
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        
        for (line) in layout {
            for run in line {
                if run.isEmpty { continue }
                if run [HighLight.self] != nil {
                    let path = Rectangle().path(in: run.typographicBounds.rect)
                    ctx.fill(path, with: .color(color))
                }
                
            }
            ctx.draw(line)
        }
    }
    
}

// Additional extension for Sequence where elements are Equatable
public extension Sequence where Element: Equatable {
    /// Returns true if the sequence is equal to another sequence (order matters)
    func isEqual(to element: Self) -> Bool {
        return self.elementsEqual(element)
    }
    
    /// Returns true if the sequence is different from another sequence
    func isDifferent(from element: Self) -> Bool {
        return !self.elementsEqual(element)
    }
}



#Preview {
    NavigationStack {
        TextHighlightView()
    }
}
