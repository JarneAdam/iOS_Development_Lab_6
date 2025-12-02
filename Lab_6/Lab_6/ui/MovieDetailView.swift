//
//  MovieDetailView.swift
//  Lab_6
//
//  Created by Jarne Adam on 19/11/2025.
//

import SwiftUI

struct MovieDetailView: View {
    var selectedMovie : Movie
    var body: some View {
        VStack{
            Text("\(selectedMovie.title)").font(.title).foregroundStyle(.red)
            Text("\(selectedMovie.description)").font(.callout)
            Divider().overlay(.tint)
            Spacer()
            Text("Actors").fontWeight(.bold)
            ForEach(selectedMovie.actors, id:\.self) { actor in
                NavigationLink("\(actor.firstName) \(actor.lastName)", value: Route.actor(actor)).buttonStyle(LinkButtonStyle()).foregroundStyle(.red)
            }
            Divider().overlay(.tint)
            Text("Director").fontWeight(.bold)
            NavigationLink(selectedMovie.director.firstName, value: Route.director(selectedMovie.director)).buttonStyle(LinkButtonStyle()).foregroundStyle(.red)
            Spacer()
            Divider().overlay(.tint)
            Text("Overview navigationStack").fontWeight(.bold)
            PathView()
        }
    }
}
