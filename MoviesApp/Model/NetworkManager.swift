//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import Foundation

enum Paths {
    case allMovies(_ key: String)
    
    var url: URL? {
        switch self {
        case .allMovies(let key):
            return URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(key)")
        
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
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(ClientResponse.self, from: data)
                    completionHandler(decoded.results)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
