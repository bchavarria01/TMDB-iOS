//
//  TvShowsEpisodesPerSeason+CoreDataProperties.swift
//  TMDB
//
//  Created by Byron Chavarría on 1/1/21.
//
//

import Foundation
import CoreData


extension TvShowsEpisodesPerSeason {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShowsEpisodesPerSeason> {
        return NSFetchRequest<TvShowsEpisodesPerSeason>(entityName: "TvShowsEpisodesPerSeason")
    }

    @NSManaged public var tvShowId: NSNumber?
    @NSManaged public var seasonName: String?
    @NSManaged public var episodeName: String?
    @NSManaged public var episodeImage: Data?

}

extension TvShowsEpisodesPerSeason : Identifiable {

}
