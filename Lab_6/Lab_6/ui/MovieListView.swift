//
//  MovieListView.swift
//  Lab_6
//
//  Created by Jarne Adam on 19/11/2025.
//

import SwiftUI

struct MovieListView: View {
    @State var selectedMovie: Movie?
    @State var loading: Bool = true
    @Environment(PathStore.self) var pathStore
    @Environment(MovieDataStore.self) var dataStore
    var body: some View {
        @Bindable var pathStore = pathStore
        NavigationStack(path: $pathStore.path) {
            if loading {
                ProgressView("Loading movies...")
            } else {
                List(dataStore.getMovies(), id:\.self, selection: $selectedMovie) {movie in
                    NavigationLink(value: Route.movie(movie)) {
                        VStack(alignment: .leading) {
                            Text("\(movie.title)").bold()
                            Text("\(movie.description)").italic().lineLimit(2).foregroundColor(.black)
                            //Divider().overlay(.tint)
                        }
                        
                    }
                }.navigationDestination(for: Route.self) { route in
                    switch route {
                    case let .actor(actor: actor):
                        ActorDetailView(actor: actor)
                    case let .director(director: director):
                        DirectorDetailView(director: director)
                    case let .movie(movie: movie):
                        MovieDetailView(selectedMovie:  movie)
                    }
                }
            }
            
        }.task {
            await dataStore.loadData()
            loading = false
        }
    }
    
}
