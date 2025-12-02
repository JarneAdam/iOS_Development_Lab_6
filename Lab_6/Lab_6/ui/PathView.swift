//
//  PathView.swift
//  Lab_6
//
//  Created by Jarne Adam on 02/12/2025.
//

import SwiftUI

struct PathView: View {
    @Environment(PathStore.self) var pathStore
    
    var body: some View {
        VStack{
            ForEach(Array(pathStore.path.enumerated()), id: \.offset) { index, route in
                switch route {
                    case let .actor(actor: actor):
                    Button("Actor \(actor.firstName) \(actor.lastName)") {
                        pathStore.reduceArray(index: index)
                    }.buttonStyle(.borderless)
                case let .director(director: director):
                    Button("Director \(director.firstName) \(director.lastName)") {
                        pathStore.reduceArray(index: index)
                    }.buttonStyle(.plain)
                case let .movie(movie:movie):
                    Button("Movie \(movie.title)") {
                        pathStore.reduceArray(index: index)
                    }.buttonStyle(.link)
                }
            }
            Button("Clear") {
                pathStore.clear()
            }
        }
    }
}
