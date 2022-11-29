//
//  Details.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import UIKit

struct Details: Identifiable {
    let id: Int
    var backdropPath: String = ""
    var backdropImage: UIImage?
    let duration: Int
    let genres: [Genre]
    
    func convertDurationTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        return formatter.string(from: TimeInterval(duration * 60)) ?? ""
    }
}

extension Details: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case duration = "runtime"
        case genres 
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawBackdrop = try? values.decode(String.self, forKey: .backdropPath)
        let rawDuration = try? values.decode(Int.self, forKey: .duration)
//        let rawGenres = try? values.decode([Genre.self], forKey: .genres)
        
        guard let id = rawId,
              let backdropPath = rawBackdrop,
              let duration = rawDuration else {
            throw CustomError.decodingFailure
        }
        
        self.id = id
        self.duration = duration
        self.backdropPath = backdropPath
        self.backdropImage = UIImage()
        self.genres = [Genre(id: 1, name: "")]
    }
}

extension Details: Hashable {
    static func == (lhs: Details, rhs: Details) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
