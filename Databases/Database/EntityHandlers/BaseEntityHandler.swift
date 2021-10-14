//
//  BaseEntityHandler.swift
//  GetirTodo
//
//  Created by Afzal Murtaza on 05/09/2021.
//

import Foundation
import  CoreData

public class BaseEntityHandler {
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>? {
        assert(true, "Method not overidden")
        return nil
    }
    func withId(entityId: Any, context: NSManagedObjectContext) -> GIManagedObject? {
        assert(true, "Method not overidden")
        return nil
    }
    
    func create<T: NSManagedObject>(context: NSManagedObjectContext) -> T {
        assert(true, "Method not overidden")
        return NSManagedObject() as! T
    }
    
    func clear(on context: NSManagedObjectContext) {
        let request = self.fetchRequest()
        do {
            let results = try context.fetch(request!)
            for object in results {
                context.delete(object as! NSManagedObject)
            }
        } catch {
            print (error)
        }
    }
    
}
