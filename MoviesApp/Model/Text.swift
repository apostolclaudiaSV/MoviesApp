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
    case appName
    case userDefaultsMoviesKey
    case userDefaulsFavoritesKey
    case fileName(id: Int)
    case filePath(id: Int)
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
        case .appName:
            return "MoviesApp"
        case .userDefaultsMoviesKey:
            return "cachedMovies"
        case .userDefaulsFavoritesKey:
            return "favoriteMovies"
        case .fileName(let id):
            return "image\(id).png"
        case .filePath(let id):
            return Text.appName.text + "/" + Text.fileName(id: id).text
        }
    }
}
