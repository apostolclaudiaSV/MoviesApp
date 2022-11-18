//
//  ClientResponse.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import Foundation

struct ClientResponse {
    private(set) var results: [Movie] = []
}

extension ClientResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let resultstContainer = try decoder.container(keyedBy: CodingKeys.self)
        var moviesContainer = try resultstContainer.nestedUnkeyedContainer(forKey: .results)
        while !moviesContainer.isAtEnd {
            if let movie = try? moviesContainer.decode(Movie.self) {
                results.append(movie)
            }
        }
    }
}
