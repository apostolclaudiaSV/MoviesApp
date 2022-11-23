//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import UIKit

enum Paths {
    case allMovies(_ key: String)
    case poster(_ path: String)
    
    var url: URL? {
        switch self {
        case .allMovies(let key):
            return URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(key)")
        case .poster(let path):
            return URL(string: "https://image.tmdb.org/t/p/w500" + path)
        }
    }
}

class NetworkManager {
    private let key = "626d05abf324b3be1c089c695497d49c"

    func getAllMovies(completionHandler: @escaping (Result<[Movie], CustomErrors>) -> Void) {
        guard let url = Paths.allMovies(key).url else {
            fatalError("error getting movie list")
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(ClientResponse.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(decoded.results))
                    }
                } catch {
                    completionHandler(.failure(CustomErrors.decodingFailure))
                }
            }
        }.resume()
    }
    
    func displayPosterImage(for movies: [Movie]) {
        movies.forEach { movie in
            let url = Paths.poster(movie.poster).url
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    MoviesListManager.shared.updateImageFor(for: movie, image: UIImage(data: data ?? Icon.noImage.data)!)
                }
            }
        }
    }
}
