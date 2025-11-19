//
//  MovieDataStore.swift
//  Movies
//
//  Created by Dirk Hostens on 04/12/2023.
//

import Foundation

@Observable
class MovieDataStore {
    private var movies = Movies()
    
    init(){
        
        
    }
    
    func getMovies() -> [Movie] {
        return movies.movies
    }
    
    func getMovies(actor: Actor) -> [Movie] {
        let movies = movies.movies.filter { movie in
            movie.actors.contains(actor)
        }
        return movies
    }
    
    func getMovies(director: Director) -> [Movie] {
        let movies = movies.movies.filter { movie in
            movie.director == director
        }
        return movies
    }
    
    func getActors(director: Director) -> [Actor] {
        let movies = getMovies(director: director)
        var actors = [Actor]()
        for movie in movies {
            for actor in movie.actors {
                actors.append(actor)
            }
        }
        return Array(Set(actors))
    }
    
    private func sort() {
        movies.movies.sort { m1, m2 in
            m1.title < m2.title
        }
    }
    
    func loadData() async {
        //simulate async call
        do {
            print("⏳ Simulating 2-second load delay...")
            try await Task.sleep(for: .seconds(2)) // Simulate long load
            movies = load("movies.json")
            sort()
            print("✅ Data loaded successfully.")
            
        } catch {
            print("❌ Failed to load data:", error)
            movies = Movies()
        }
    }
}
