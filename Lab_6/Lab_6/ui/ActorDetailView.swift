//
//  ActorDetailView.swift
//  Lab_6
//
//  Created by Jarne Adam on 19/11/2025.
//

import SwiftUI

struct ActorDetailView: View {
    var actor : Actor? = nil
    @Environment(MovieDataStore.self) private var dataStore
    
    var body: some View {
        VStack {
            Text("Actor: \(actor!.firstName) \(actor!.lastName)").bold().foregroundStyle(.red)
            Divider().overlay(.tint)
            Text("Birthday: \(actor!.birthday)")
            Spacer()
            Divider().overlay(.tint)
            Text("Movie(s)").fontWeight(.bold)
            ForEach(dataStore.getMovies(actor: actor!), id: \.self) { movie in
                NavigationLink(movie.title, value: Route.movie(movie)).buttonStyle(LinkButtonStyle()).foregroundStyle(.red)
            }
            Spacer()
            Divider().overlay(.tint)
            Text("Overview navigationStack").fontWeight(.bold)
            PathView()
        }
    }
}
