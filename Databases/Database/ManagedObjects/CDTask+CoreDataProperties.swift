//
//  CDTask+CoreDataProperties.swift
//  GetirTodo
//
//  Created by Afzal Murtaza on 06/09/2021.
//
//

import Foundation
import CoreData


extension CDTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        return NSFetchRequest<CDTask>(entityName: "CDTask")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var iD: String
    @NSManaged public var taskDescription: String
    @NSManaged public var taskTitle: String

}

extension CDTask : Identifiable {

}
