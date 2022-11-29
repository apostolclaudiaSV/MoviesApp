//
//  Text.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import Foundation

enum Text {
    case maximumRating
    case allMovies
    case favoritesMovies
}

extension Text {
    var text: String {
        switch self {
        case .maximumRating:
            return "/10"
        case .allMovies:
            return "All Movies"
        case .favoritesMovies:
            return "Favorites"
        }
    }
}
