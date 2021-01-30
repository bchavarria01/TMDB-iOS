//
//  UserInfo+CoreDataProperties.swift
//  
//
//  Created by Byron Chavarría on 30/1/21.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var imagePath: String?
    @NSManaged public var userId: String?
    @NSManaged public var username: String?

}
