//
//  Movie.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/9/22.
//

import UIKit

struct Movie {
    let title: String
    var rating: Double
    let releaseDate: Date
    var isFavourite: Bool = false
    let overview: String
    let poster: UIImage
    let details: Details?
    let popularity: Double
 
    var releaseYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: releaseDate)
    }
}
