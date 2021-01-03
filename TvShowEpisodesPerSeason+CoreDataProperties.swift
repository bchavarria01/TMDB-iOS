//
//  TvShowEpisodesPerSeason+CoreDataProperties.swift
//  TMDB
//
//  Created by Byron Chavarría on 2/1/21.
//
//

import Foundation
import CoreData


extension TvShowEpisodesPerSeason {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShowEpisodesPerSeason> {
        return NSFetchRequest<TvShowEpisodesPerSeason>(entityName: "TvShowEpisodesPerSeason")
    }

    @NSManaged public var episodeId: Int32
    @NSManaged public var episodeImage: Data?
    @NSManaged public var episodeName: String?
    @NSManaged public var seasonName: String?
    @NSManaged public var tvShowId: NSNumber?

}

extension TvShowEpisodesPerSeason : Identifiable {

}
