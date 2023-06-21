//
//  GenreDB+CoreDataProperties.swift
//  MoviesApp
//
//  Created by claudia.apostol on 6/21/23.
//
//

import Foundation
import CoreData


extension GenreDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreDB> {
        return NSFetchRequest<GenreDB>(entityName: "GenreDB")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var newRelationship: NSSet?

}

// MARK: Generated accessors for newRelationship
extension GenreDB {

    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: DetailsDB)

    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: DetailsDB)

    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: NSSet)

    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: NSSet)

}

extension GenreDB : Identifiable {

}
