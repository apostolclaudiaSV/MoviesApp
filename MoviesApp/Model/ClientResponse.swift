//
//  ClientResponse.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import Foundation

struct ClientResponse: Decodable {
    private(set) var results: [Movie] = []
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var moviesContainer = try rootContainer.nestedUnkeyedContainer(forKey: .results)
        while !moviesContainer.isAtEnd {
            if let movie = try? moviesContainer.decode(Movie.self) {
                results.append(movie)
            }
        }
    }
}
