//
//  TvShowDetail+CoreDataProperties.swift
//  TMDB
//
//  Created by Byron Chavarría on 1/1/21.
//
//

import Foundation
import CoreData


extension TvShowDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShowDetail> {
        return NSFetchRequest<TvShowDetail>(entityName: "TvShowDetail")
    }

    @NSManaged public var lastSeasonReleaseDate: String?
    @NSManaged public var lastSeasonName: String?
    @NSManaged public var lastSeasonImage: Data?
    @NSManaged public var createdBy: String?
    @NSManaged public var tvShowDetailDescription: String?
    @NSManaged public var tvShowDetailName: String?
    @NSManaged public var tvShowDetailRate: Float
    @NSManaged public var tvShowDetailImage: Data?
    @NSManaged public var tvShowId: NSNumber?

}

extension TvShowDetail : Identifiable {

}
