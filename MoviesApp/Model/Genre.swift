//
//  Genre.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import Foundation

struct Genre: Identifiable {
    let id: Int
    let name: String
}

extension Genre: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawName = try? values.decode(String.self, forKey: .name)
        
        guard let id = rawId,
              let name = rawName else {
            throw CustomError.decodingFailure
        }
        
        self.id = id
        self.name = name
    }
}
