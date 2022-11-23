//
//  MovieList.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/9/22.
//

import UIKit

enum SortCriteria {
    case titleAsc
    case titleDesc
    case ratingDesc
    case popularityDesc
    case releaseDesc
    case none
}

enum FilterCriteria {
    case favourites
    case rating(value: Double)
    case none
}

class MoviesListManager {
    static let shared = MoviesListManager()
    
    private init() {}
    
    private (set) var allMovies = unsortedMovies

    func updateAllMovies(with newMoviesList: [Movie]) {
        allMovies = newMoviesList
        NotificationCenter.default.post(name: .DatasourceChanged, object: nil)
    }
    
    func sortedAndFiltered(by sortCriteria: SortCriteria, filterCriteria: FilterCriteria) -> [Movie] {
        let sortedMovies = allMovies.sorted(by: sortCriteria)
        return sortedMovies.filtered(by: filterCriteria)
    }
        
    func modifyFavorite(for movie: Movie) {
        let index = getIndexOfSortedMovie(movie)
        allMovies[index].isFavourite.toggle()
    }
    
    func updateImageFor(for movie: Movie, image: UIImage) {
        let index = getIndexOfSortedMovie(movie)
        allMovies[index].setPosterImage(image)
        NotificationCenter.default.post(name: .ImageLoaded, object: movie)
    }
    
    private func allImagesSet() -> Bool {
        return allMovies.filter { $0.posterImage != nil }.count == allMovies.count
    }
    
    func getIndexOfSortedMovie(_ movie: Movie) -> Int{
        return allMovies.firstIndex(where: {$0.title == movie.title}) ?? 0
    }
    
    static var unsortedMovies: [Movie] = [
        Movie(title: "Spider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way HomeSpider-Man: No Way Home", rating: 8.7, releaseDate: Date(timeIntervalSinceNow: -12), overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes og being a superhero.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 100000),
        Movie(title: "Venom: Let There Be Carnage", rating: 7.2, releaseDate: Date(timeIntervalSinceNow: -1200), overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes og being a superhero.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 9999.999),
        Movie(title: "Red Notice", rating: 6.8, releaseDate: Date(timeIntervalSinceNow: -120), overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes og being a superhero.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 2627.102),
        Movie(title: "Fast and Furious", rating: 9.7, releaseDate: Date(timeIntervalSinceNow: -120000), overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes og being a superhero.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 2005.684),
        Movie(title: "Shang-Chi and the Legend of the Ten Rings", rating: 7.8, releaseDate: Date(timeIntervalSinceNow: -1234558), overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes og being a superhero.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 1626.581),
        Movie(title: "Pinocchio", rating: 6.7, releaseDate: Date(timeIntervalSinceNow: -1234558), overview: "A wooden puppet embarks on a thrilling adventure to become a real boy.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 1017.959),
        Movie(title: "Thor: Love and Thunder", rating: 6.7, releaseDate: Date(timeIntervalSinceNow: -1234558), overview: "After his retirement is interrupted by Gorr the God Butcher, a galactic killer who seeks the extinction of the gods, Thor Odinson enlists the help of King Valkyrie, Korg, and ex-girlfriend Jane Foster, who now wields Mjolnir as the Mighty Thor. Together they embark upon a harrowing cosmic adventure to uncover the mystery of the God Butcher’s vengeance and stop him before it’s too late.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 1089.265),
        Movie(title: "Hocus Pocus 2", rating: 7.6, releaseDate: Date(timeIntervalSinceNow: -1234558), overview: "29 years since the Black Flame Candle was last lit, the 17th-century Sanderson sisters are resurrected, and they are looking for revenge. Now it's up to three high school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow's Eve.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 1249.496),
        Movie(title: "Terrifier", rating: 6.5, releaseDate: Date(timeIntervalSinceNow: -1234558), overview: "After witnessing a brutal murder on Halloween night, a young woman becomes the next target of a maniacal entity.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 1060.37),
        Movie(title: "Terrifier 2", rating: 7.1, releaseDate: Date(timeIntervalSinceNow: -1234558), overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 4608.567),
        Movie(title: "Black Adam", rating: 6.8, releaseDate: Date(timeIntervalSinceNow: -1234558), isFavourite: true, overview: "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 3193.354),
        Movie(title: "Top Gun: Maverick", rating: 8.3, releaseDate: Date(timeIntervalSinceNow: -1234558), isFavourite: true, overview: "After more than thirty years of service as one of the Navy’s top aviators, and dodging the advancement in rank that would ground him, Pete “Maverick” Mitchell finds himself training a detachment of TOP GUN graduates for a specialized mission the likes of which no living pilot has ever seen.", poster: "", details: Details(duration: 121, genres: [Genre(id: 1, name: "Action")]), popularity: 1219.263)
    ]
}
