//
//  Show+CoreDataProperties.swift
//  TMDB
//
//  Created by Byron Chavarría on 2/1/21.
//
//

import Foundation
import CoreData


extension Show {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Show> {
        return NSFetchRequest<Show>(entityName: "Show")
    }

    @NSManaged public var tvShowDescription: String?
    @NSManaged public var tvShowId: NSNumber?
    @NSManaged public var tvShowImage: Data?
    @NSManaged public var tvShowName: String?
    @NSManaged public var tvShowRate: Float
    @NSManaged public var tvShowReleaseDate: String?
    @NSManaged public var type: Int32

}

extension Show : Identifiable {

}
