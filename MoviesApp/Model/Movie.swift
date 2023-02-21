//
//  Movie.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/9/22.
//

import UIKit

class Movie: Identifiable {
    let id: Int
    let title: String
    var rating: Double
    var releaseDate: Date
    var isFavourite: Bool = false
    let overview: String
    let poster: String
    var details: Details? = nil
    let popularity: Double
    var posterImage: UIImage?
    
    var releaseYear: String { releaseDate.getYearFromDate() }
    
    init(id: Int, title: String, rating: Double, releaseDate: Date, isFavourite: Bool, overview: String, poster: String, details: Details? = nil, popularity: Double, posterImage: UIImage? = nil) {
        self.id = id
        self.title = title
        self.rating = rating
        self.releaseDate = releaseDate
        self.isFavourite = isFavourite
        self.overview = overview
        self.poster = poster
        self.details = details
        self.popularity = popularity
        self.posterImage = posterImage
    }
    
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawTitle = try? values.decode(String.self, forKey: .title)
        let rawOverview = try? values.decode(String.self, forKey: .overview)
        let rawRating = try? values.decode(Double.self, forKey: .rating)
        let rawDate = try? values.decode(String.self, forKey: .releaseDate)
        let rawPosterPath = try? values.decode(String.self, forKey: .poster)
        
        guard let title = rawTitle,
              let id = rawId,
              let overview = rawOverview,
              let rating = rawRating?.truncate(places: 1),
              let date = rawDate?.toDate() else {
            throw CustomError.decodingFailure
        }
        
        self.init(id: id, title: title, rating: rating, releaseDate: date, isFavourite: false, overview: overview, poster: rawPosterPath ?? "", popularity: 0)
    }
    
    func setPosterImage(_ image: UIImage) {
        self.posterImage = image
    }
    
    func getIndexOfSimilarMovie(_ movie: Movie) -> Int? {
        return details?.similarMovies.firstIndex(where: {$0.id == movie.id})
    }
    
    func setBackdropImage(_ image: UIImage) {
        self.details?.backdropImage = image
    }
    
    func getFavoriteImageColor() -> UIColor {
        return isFavourite ? .red : .white
    }
    
    func getFavoriteImage() -> UIImage {
        let favoriteImage = isFavourite ? Icon.heartFill.image : Icon.heart.image
        return favoriteImage.withTintColor(getFavoriteImageColor(
        ), renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(scale: .medium))
    }
}

extension Movie: Codable {
    private enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case title
        case overview
        case id
        case releaseDate = "release_date"
        case poster = "poster_path"
    }
}
