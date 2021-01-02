//
//  TvShows+CoreDataProperties.swift
//  TMDB
//
//  Created by Byron Chavarría on 1/1/21.
//
//

import Foundation
import CoreData


extension TvShows {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShows> {
        return NSFetchRequest<TvShows>(entityName: "TvShows")
    }

    @NSManaged public var tvShowDescription: String?
    @NSManaged public var tvShowRate: Float
    @NSManaged public var tvShowReleaseDate: String?
    @NSManaged public var tvShowName: String?
    @NSManaged public var tvShowImage: Data?
    @NSManaged public var tvShowId: NSNumber?
    @NSManaged public var type: Int32

}

extension TvShows : Identifiable {

}
