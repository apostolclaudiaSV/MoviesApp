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
        self.results = try resultstContainer.decode([Movie].self, forKey: .results)
    }
}
