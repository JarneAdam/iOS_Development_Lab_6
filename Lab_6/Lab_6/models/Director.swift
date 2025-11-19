//
//  Director.swift
//  Movies
//
//  Created by Dirk Hostens on 04/12/2023.
//

import Foundation

struct Director: Codable, Hashable {
    var firstName: String
    var lastName: String
    var moviesDirected: [String]
}
