//
//  TvShowList+CoreDataProperties.swift
//  
//
//  Created by Byron Chavarría on 3/1/21.
//
//

import Foundation
import CoreData


extension TvShowList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShowList> {
        return NSFetchRequest<TvShowList>(entityName: "TvShowList")
    }

    @NSManaged public var tvShowDescription: String?
    @NSManaged public var tvShowId: NSNumber?
    @NSManaged public var tvShowImage: Data?
    @NSManaged public var tvShowName: String?
    @NSManaged public var tvShowRate: Float
    @NSManaged public var tvShowReleaseDate: String?
    @NSManaged public var type: Int32

}
