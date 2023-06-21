//
//  MovieDB+CoreDataProperties.swift
//  MoviesApp
//
//  Created by claudia.apostol on 6/21/23.
//
//

import Foundation
import CoreData


extension MovieDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDB> {
        return NSFetchRequest<MovieDB>(entityName: "MovieDB")
    }

    @NSManaged public var id: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster: Bool
    @NSManaged public var posterImage: Data?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: Date?
    @NSManaged public var releaseYear: String?
    @NSManaged public var title: String?
    @NSManaged public var details: DetailsDB?

}

extension MovieDB : Identifiable {

}
