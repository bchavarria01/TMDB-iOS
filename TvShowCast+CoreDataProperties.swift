//
//  TvShowCast+CoreDataProperties.swift
//  TMDB
//
//  Created by Byron Chavarría on 2/1/21.
//
//

import Foundation
import CoreData


extension TvShowCast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShowCast> {
        return NSFetchRequest<TvShowCast>(entityName: "TvShowCast")
    }

    @NSManaged public var castImage: Data?
    @NSManaged public var castName: String?
    @NSManaged public var tvShowId: NSNumber?

}

extension TvShowCast : Identifiable {

}
