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
    var releaseDate: Date
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

extension Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case title
        case overview
        case releaseDate = "release_date"
        //case poster = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawTitle = try? values.decode(String.self, forKey: .title)
        let rawOverview = try? values.decode(String.self, forKey: .overview)
        let rawRating = try? values.decode(Double.self, forKey: .rating)
        let rawDate = try? values.decode(String.self, forKey: .releaseDate)
        
        guard let title = rawTitle,
              let overview = rawOverview,
              let rating = rawRating,
              let date = rawDate?.toDate() else {
            throw CustomErrors.decodingFailure
        }

        self.title = title
        self.rating = rating
        self.overview = overview
        self.releaseDate = date
        self.poster = UIImage()
        self.details = Details(duration: 1, genres: [Genre(id: 1, name: "")])
        self.popularity = 0
    }
}

