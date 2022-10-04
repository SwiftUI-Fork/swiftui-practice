//
//  MorphingView.swift
//  Morphing
//
//  Created by HIROKI IKEUCHI on 2022/10/04.
//

import SwiftUI

struct MorphingView: View {
    
    @State private var currentImage: CustomShape = .cloud
    @State private var turnOffImageMorph: Bool = false

    var body: some View {
        VStack {
            
            // Morph is simple
            // Simply Mask the canvas sha;e as image mask
            GeometryReader { proxy in
                let size = proxy.size
                Image("iJustine")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -20, y: 40)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .overlay(content: {
                        Rectangle()
                            .fill(.white)
                            .opacity(turnOffImageMorph ? 1 : 0)
                    })
                    .mask {
                        // MARK: Morphing shapes with the help of Canvas and Filters
                        Canvas { context, size in
                            if let resolvedImage = context.resolveSymbol(id: 1) {
                                context.draw(resolvedImage,
                                             at: CGPoint(x: size.width / 2, y: size.height / 2),
                                             anchor: .center)
                            }
                        } symbols: {
                            // MARK: Giving images with ID
                            ResolvedImage(currentImage: $currentImage)
                                .tag(1)
                        }
                    }
            }
            .frame(height: 400)
            
            Picker("", selection: $currentImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            .padding(15)
            .padding(.top, -50)
            
            Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
                .fontWeight(.semibold)
                .padding(.horizontal, 15)
                .padding(.top, 10)
        }
        .offset(y: -50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 200))
            .animation(.interactiveSpring(response: 0.7,
                                          dampingFraction: 0.8,
                                          blendDuration: 0.8),
                       value: currentImage)
            .frame(width: 300, height: 300)
    }
}

struct MorphingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
