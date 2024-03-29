//
//  Session+CoreDataProperties.swift
//  
//
//  Created by Byron Chavarría on 30/1/21.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var expDate: String?
    @NSManaged public var sessionId: String?
    @NSManaged public var token: String?

}
