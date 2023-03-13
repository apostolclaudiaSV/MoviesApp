//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import UIKit

enum Paths {
    case allMovies(_ key: String, page: Int, sortCriteria: SortCriteria)
    case poster(_ path: String)
    case movieDetails(key: String, id: Int)
    case similarMovies(key: String, id: Int)
    
    var url: URL? {
        switch self {
        case .allMovies(let key, let page, let sortCriteria):
            return URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(key)&page=\(page)&sort_by=\(sortCriteria.parameterName)")
        case .poster(let path):
            return URL(string: "https://image.tmdb.org/t/p/w500" + path)
        case .movieDetails(let key, let id):
            return URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(key)")
        case .similarMovies(let key, let id):
            return URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(key)")
        }
    }
}

protocol MovieFetchStrategy {
    func fetchMovies(pageNumber: Int, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void)
}

class MoviesAPIService: MovieFetchStrategy {
    func fetchMovies(pageNumber: Int = 1, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void) {
        getAllMovies(pageNumber: pageNumber, completionHandler: completionHandler)
    }
    
    private let key = "626d05abf324b3be1c089c695497d49c"
    
    private func decode <T: Decodable>(from url: URL, decodingType: T.Type, completionHandler: @escaping (Result<T, CustomError>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return completionHandler(.failure(CustomError.decodingFailure))
            }
            do {
                let decoded = try JSONDecoder().decode(decodingType, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(decoded))
                }
            } catch {
                completionHandler(.failure(CustomError.decodingFailure))
            }
        }.resume()
    }
    
    private func decodeImage(from url: URL, completionHandler: @escaping (UIImage?) -> Void = {_ in }) {
        let data = try? Data(contentsOf: url)
        DispatchQueue.main.async {
            guard let data = data, let image = UIImage(data: data) else {
                completionHandler(nil)
                return
            }
            completionHandler(image)
        }
    }
    
    func getAllBaseMovies(url: URL, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void) {
        decode(from: url, decodingType: ClientResponse.self) { (result: Result<ClientResponse, CustomError>) in
            switch result {
            case .success(let response):
                self.getPosterImages(for: response.results)
                completionHandler(.success(response.results))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getAllSimilarMovies(id: Int, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void) {
        guard let url = Paths.similarMovies(key: key, id: id).url else {
            fatalError("error getting movies")
        }
        self.getAllBaseMovies(url: url, completionHandler: completionHandler)
    }
    
    func getAllMovies(pageNumber: Int = 1, sortCriteria: SortCriteria = .none, completionHandler: @escaping (Result<[Movie], CustomError>) -> Void) {
        guard let url = Paths.allMovies(key, page: pageNumber, sortCriteria: sortCriteria).url else {
            fatalError("error getting movies")
        }
        self.getAllBaseMovies(url: url, completionHandler: completionHandler)
    }
    
    func getMovieDetails(for id: Int, completionHandler: @escaping (Result<Details, CustomError>) -> Void) {
        guard let url = Paths.movieDetails(key: key, id: id).url else {
            fatalError("error getting movie details")
        }
        decode(from: url, decodingType: Details.self, completionHandler: completionHandler)
    }
    
    
    private func getPosterImages(for movies: [Movie]) {
        movies.forEach { movie in
            self.getPosterImage(for: movie) { _ in
            }
        }
    }
    
    private func getPosterImage(for movie: Movie, completion: @escaping (UIImage?) -> Void) {
        guard let url = Paths.poster(movie.poster).url else {
            completion(nil)
            return
        }
        if let image = MoviesDataClient.shared.getImage(for: movie.id) {
            print("using cached image")
            completion(image)
            return
        }
        
        if let image = MoviesDataClient.shared.getImageFromFile(for: movie.id) {
            print("using image from file manager")
            movie.setPosterImage(image)
            completion(image)
            return
        }
        DispatchQueue.global().async {
            self.decodeImage(from: url) { image in
                MoviesDataClient.shared.updateImageFor(for: movie, image: image ?? Icon.noImage.image)
            }
        }
    }
    
    func getBackDropImage(for path: String?, completion: @escaping (UIImage?) -> Void) {
        guard let path = path, let url = Paths.poster(path).url else {
            completion(nil)
            return
        }
        DispatchQueue.global().async {
            self.decodeImage(from: url, completionHandler: completion)
        }
    }
    
    func downloadDetails(for id: Int) {
        getMovieDetails(for: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                MoviesDataClient.shared.setDetails(for: id, details: details)
                self.getBackDropImage(for: details.backdropPath) { [weak self] image in
                    guard let self = self else { return }
                    MoviesDataClient.shared.setBackDrop(for: id, image: image)
                    self.getAllSimilarMovies(id: id) { result in
                        switch result {
                        case .success(let movies):
                            MoviesDataClient.shared.setSimilarMovies(for: id, movies: movies)
                        case .failure:
                            MoviesDataClient.shared.setSimilarMovies(for: id, movies: [])
                        }
                    }
                }
            case .failure:
                MoviesDataClient.shared.setSimilarMovies(for: id, movies: [])
            }
        }
   }
}
