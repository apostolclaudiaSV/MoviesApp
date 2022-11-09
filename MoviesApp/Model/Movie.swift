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


struct Details {
    let duration: Int
    let genres: [Genre]
    
    func convertDurationTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        return formatter.string(from: TimeInterval(duration * 60)) ?? ""
    }
}

struct Genre: Identifiable {
    let id: Int
    let name: String
}
