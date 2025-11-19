//
//  Movie.swift
//  Movies
//
//  Created by Dirk Hostens on 04/12/2023.
//

import Foundation

struct Movie: Codable, Hashable {
    var title: String
    var description: String
    var actors: [Actor]
    var director: Director
    var releaseDate: String
}
