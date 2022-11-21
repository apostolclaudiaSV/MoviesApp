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

    func getAllMovies(completionHandler: @escaping ([Movie]) -> Void) {
        guard let url = Paths.allMovies(key).url else {
            fatalError("error getting movie list")
        }
        let session = URLSession.shared
        session.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(ClientResponse.self, from: data)
                    completionHandler(decoded.results)
                    //self?.displayPosterImage(for: decoded.result)
                } catch {
                    print(error)
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