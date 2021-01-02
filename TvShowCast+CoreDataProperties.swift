//
//  TvShowCast+CoreDataProperties.swift
//  TMDB
//
//  Created by Byron Chavarría on 1/1/21.
//
//

import Foundation
import CoreData


extension TvShowCast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShowCast> {
        return NSFetchRequest<TvShowCast>(entityName: "TvShowCast")
    }

    @NSManaged public var tvShowId: NSNumber?
    @NSManaged public var castImage: Data?
    @NSManaged public var castName: String?

}

extension TvShowCast : Identifiable {

}
