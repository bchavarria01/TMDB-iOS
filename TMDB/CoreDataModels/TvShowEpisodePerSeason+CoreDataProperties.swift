//
//  TvShowEpisodePerSeason+CoreDataProperties.swift
//  
//
//  Created by Byron Chavarría on 3/1/21.
//
//

import Foundation
import CoreData


extension TvShowEpisodePerSeason {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShowEpisodePerSeason> {
        return NSFetchRequest<TvShowEpisodePerSeason>(entityName: "TvShowEpisodePerSeason")
    }

    @NSManaged public var episodeId: Int32
    @NSManaged public var episodeImage: Data?
    @NSManaged public var episodeName: String?
    @NSManaged public var seasonName: String?
    @NSManaged public var tvShowId: NSNumber?

}
