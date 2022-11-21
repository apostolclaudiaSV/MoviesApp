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
    let poster: String
    let details: Details?
    let popularity: Double
    var posterImage: UIImage?
    
    var releaseYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: releaseDate)
    }
    
    mutating func setPosterImage(_ image: UIImage) {
        self.posterImage = image
    }
}

extension Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case title
        case overview
        case releaseDate = "release_date"
        case poster = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawTitle = try? values.decode(String.self, forKey: .title)
        let rawOverview = try? values.decode(String.self, forKey: .overview)
        let rawRating = try? values.decode(Double.self, forKey: .rating)
        let rawDate = try? values.decode(String.self, forKey: .releaseDate)
        let rawPosterPath = try? values.decode(String.self, forKey: .poster)
        
        guard let title = rawTitle,
              let overview = rawOverview,
              let rating = rawRating,
              let poster = rawPosterPath,
              let date = rawDate?.toDate() else {
            throw CustomErrors.decodingFailure
        }

        self.title = title
        self.rating = rating
        self.overview = overview
        self.releaseDate = date
        self.poster = poster
        self.details = Details(duration: 1, genres: [Genre(id: 1, name: "")])
        self.popularity = 0
        self.posterImage = UIImage()
    }
}

