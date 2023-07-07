//
//  MovieDB+CoreDataProperties.swift
//  MoviesApp
//
//  Created by claudia.apostol on 6/21/23.
//
//

import Foundation
import CoreData
import UIKit


extension MovieDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDB> {
        return NSFetchRequest<MovieDB>(entityName: "MovieDB")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var isFavorite: Bool
    @NSManaged public var overview: String
    @NSManaged public var popularity: Double
    @NSManaged public var poster: String
    @NSManaged public var posterImage: Data?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: Date?
    @NSManaged public var releaseYear: String?
    @NSManaged public var title: String
    
//    func convertToMovie() -> Movie {
//        return Movie.init(id: Int(self.id), title: self.title, rating: self.rating, releaseDate: self.releaseDate!, isFavourite: self.isFavorite, overview: self.overview, poster: self.poster, details: nil, popularity: self.popularity, posterImage: UIImage(data: self.posterImage ?? Icon.noImage.data))
//    }
}

extension MovieDB : Identifiable {

}
