//
//  DirectorDetailView.swift
//  Lab_6
//
//  Created by Jarne Adam on 19/11/2025.
//

import SwiftUI

struct DirectorDetailView: View {
    var director : Director? = nil
    @Environment(MovieDataStore.self) private var dataStore
    var body: some View {
        if director != nil {
            VStack {
                Text("Director: \(director!.firstName) \(director!.lastName)").bold()
                Divider()
                Spacer()
                Divider().overlay(.tint)
                Text("Movie(s)").fontWeight(.bold)
                ForEach(dataStore.getMovies(director: director!), id: \.self) { movie in
                    NavigationLink(movie.title, value: Route.movie(movie)).buttonStyle(LinkButtonStyle()).foregroundStyle(.red)
                }
                Spacer()
                Divider()
                Text("Actors work with:")
                ForEach(dataStore.getActors(director: director!), id: \.self) { actor in
                    NavigationLink("\(actor.firstName) \(actor.lastName)", value: Route.actor(actor)).buttonStyle(LinkButtonStyle()).foregroundStyle(.red)
                }
                Spacer()
                Divider().overlay(.tint)
                Text("Overview navigationStack").fontWeight(.bold)
                PathView()
            }
        }
    }
}
