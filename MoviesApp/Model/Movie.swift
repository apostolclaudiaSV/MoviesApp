//
//  Movie.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/9/22.
//

import UIKit

struct Movie: Identifiable {
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
    
    mutating func setPosterImage(_ image: UIImage) {
        self.posterImage = image
    }
    
//    mutating func setSimilarMovieImage(_ image: UIImage, for movie: Movie) {
//        guard let index = getIndexOfSimilarMovie(movie) else { return }
//        self.details?.similarMovies[index]
//    }
    
    func getIndexOfSimilarMovie(_ movie: Movie) -> Int? {
        return details?.similarMovies.firstIndex(where: {$0.id == movie.id})
    }
    
    mutating func setBackdropImage(_ image: UIImage) {
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

extension Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case title
        case overview
        case id
        case releaseDate = "release_date"
        case poster = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
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
              let rating = rawRating,
              let poster = rawPosterPath,
              let date = rawDate?.toDate() else {
            throw CustomError.decodingFailure
        }
        
        self.id = id
        self.title = title
        self.rating = rating
        self.overview = overview
        self.releaseDate = date
        self.poster = poster
        self.popularity = 0
        self.posterImage = UIImage()
    }
}

