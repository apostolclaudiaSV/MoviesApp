//
//  DetailsDB+CoreDataProperties.swift
//  MoviesApp
//
//  Created by claudia.apostol on 6/21/23.
//
//

import Foundation
import CoreData


extension DetailsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetailsDB> {
        return NSFetchRequest<DetailsDB>(entityName: "DetailsDB")
    }

    @NSManaged public var backdropImage: Data?
    @NSManaged public var backdropPath: String?
    @NSManaged public var duration: Int16
    @NSManaged public var id: Int16
    @NSManaged public var similarMovies: NSSet?
    @NSManaged public var genres: GenreDB?

}

// MARK: Generated accessors for similarMovies
extension DetailsDB {

    @objc(addSimilarMoviesObject:)
    @NSManaged public func addToSimilarMovies(_ value: MovieDB)

    @objc(removeSimilarMoviesObject:)
    @NSManaged public func removeFromSimilarMovies(_ value: MovieDB)

    @objc(addSimilarMovies:)
    @NSManaged public func addToSimilarMovies(_ values: NSSet)

    @objc(removeSimilarMovies:)
    @NSManaged public func removeFromSimilarMovies(_ values: NSSet)

}

extension DetailsDB : Identifiable {

}
