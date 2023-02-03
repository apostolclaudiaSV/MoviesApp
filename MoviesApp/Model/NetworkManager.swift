//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import UIKit

enum Paths {
    case allMovies(_ key: String, page: Int)
    case poster(_ path: String)
    case movieDetails(key: String, id: Int)
    case similarMovies(key: String, id: Int)
    
    var url: URL? {
        switch self {
        case .allMovies(let key, let page):
            return URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(key)&page=\(page)")
        case .poster(let path):
            return URL(string: "https://image.tmdb.org/t/p/w500" + path)
        case .movieDetails(let key, let id):
            return URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(key)")
        case .similarMovies(let key, let id):
            return URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(key)")
        }
    }
}

class NetworkManager {
    private let key = "626d05abf324b3be1c089c695497d49c"
        
    func getAllBaseMovies(url: URL, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return completionHandler(.failure(CustomError.decodingFailure))
            }
            do {
                let decoded = try JSONDecoder().decode(ClientResponse.self, from: data)
                DispatchQueue.main.async {
                    self.getPosterImages(for: decoded.results)
                    completionHandler(.success(decoded.results))
                }
            } catch {
                completionHandler(.failure(CustomError.decodingFailure))
            }
        }.resume()
    }
    
    func getAllSimilarMovies(id: Int, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void) {
        guard let url = Paths.similarMovies(key: key, id: id).url else {
            fatalError("error getting movies")
        }
        self.getAllBaseMovies(url: url, completionHandler: completionHandler)
    }
    
    func getAllMovies(pageNumber: Int = 1, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void) {
        guard let url = Paths.allMovies(key, page: pageNumber).url else {
            fatalError("error getting movies")
        }
        self.getAllBaseMovies(url: url, completionHandler: completionHandler)
    }
    
    func getMovieDetails(for id: Int, completionHandler: @escaping (Result<Details, CustomError>) -> Void) {
        guard let url = Paths.movieDetails(key: key, id: id).url else {
            fatalError("error getting movie details")
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return completionHandler(.failure(CustomError.decodingFailure))
            }
            do {
                
                let decoded = try JSONDecoder().decode(Details.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(decoded))
                }
            } catch {
                completionHandler(.failure(CustomError.decodingFailure))
            }
        }.resume()
    }
    
    func getSimilarMovies(for id: Int, completion: @escaping (Result<[Movie], CustomError>) -> Void) {
        guard let url = Paths.similarMovies(key: key, id: id).url else {
            fatalError("Error getting similar movies")
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(CustomError.decodingFailure))
            }
            do {
                let decoded = try JSONDecoder().decode(ClientResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded.results))
                }
            } catch {
                completion(.failure(CustomError.decodingFailure))
            }
        }.resume()
    }
    
    private func getPosterImages(for movies: [Movie]) {
        movies.forEach { movie in
            self.getPosterImage(for: movie) { _ in
            }
        }
    }
    
    private func getPosterImage(for movie: Movie, completion: @escaping (UIImage?) -> Void) {
        guard let url = Paths.poster(movie.poster).url else {
            return
        }
        if let image = MoviesListManager.shared.getImage(for: movie.id) {
            print("using cached image")
            completion(image)
            return
        }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                MoviesListManager.shared.updateImageFor(for: movie, image: image)
                completion(image)
            }
        }
    }
    
    func getBackDropImage(for path: String?, completion: @escaping (UIImage) -> Void) {
        guard let path = path, let url = Paths.poster(path).url else {
            completion(UIImage(data: Icon.noImage.data)!)
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                completion(UIImage(data: data ?? Icon.noImage.data)!)
            }
        }
    }
}
