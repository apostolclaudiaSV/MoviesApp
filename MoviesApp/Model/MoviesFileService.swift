//
//  MoviesFileService.swift
//  MoviesApp
//
//  Created by claudia.apostol on 2/15/23.
//

import Foundation

class MoviesFileService: MovieFetchStrategy {
    func fetchMovies(pageNumber: Int = 0, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void = {_ in }) {
        if let data = UserDefaults.standard.data(forKey: Text.userDefaultsMoviesKey.text) {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let arrayOfMovies = try decoder.decode([Movie].self, from: data)
                
                arrayOfMovies.forEach { movie in
                    let image = MoviesDataClient.shared.getImageFromFile(for: movie.id)
                    movie.setPosterImage(image ?? Icon.noImage.image)
                }
                MoviesDataClient.shared.addMovies(movies: arrayOfMovies)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
