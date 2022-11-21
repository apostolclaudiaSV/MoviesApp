//
//  Array+Extension.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/17/22.
//

import Foundation

extension Array where Element == Movie {
    func sorted(by criteria: SortCriteria) -> [Movie] {
        switch criteria {
        case .titleAsc: // asc title
            return self.sorted(by: {$0.title < $1.title})
        case .titleDesc: //desc title
            return self.sorted(by: {$0.title > $1.title})
        case .ratingDesc: // desc rating
            return self.sorted(by: {$0.rating > $1.rating})
        case .popularityDesc:// desc popularity
            return self.sorted(by: {$0.popularity > $1.popularity})
        case .releaseDesc: // desc release date
            return self //self.sorted(by: {$0.releaseYear > $1.releaseYear})
        case .none:
            return self
        }
        
    }
    
    func filtered(by criteria: FilterCriteria) -> [Movie] {
        switch criteria {
        case .favourites:
            return self.filter() { $0.isFavourite == true }
        case let .rating(value):
            return self.filter() { $0.rating >= value }
        case .none:
            return self
        }
    }
}
