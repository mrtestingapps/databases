//
//  TaskEntityHandler.swift
//  GetirTodo
//
//  Created by Afzal Murtaza on 05/09/2021.
//

import CoreData
public protocol TaskEntityInteraction {
    func allTasks(on context: NSManagedObjectContext) -> [CDTask]?
    func delete(task iD: String, on context: NSManagedObjectContext)
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>?
    func sortDescriptor() -> [NSSortDescriptor]
    func createTask(on context: NSManagedObjectContext, for title: String, taskDescription: String)
    func updateTask(task iD:String, on context: NSManagedObjectContext, for title: String, taskDescription: String)
}
public class TaskEntityHandler: BaseEntityHandler {
    
    public override init() {
        super.init()
    }
    public override func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>? {
        return CDTask.fetchRequest()
    }
    
    override func create<T>(context: NSManagedObjectContext) -> T where T : NSManagedObject {
        let obj = CDTask(entity: CDTask.entity(), insertInto: context)
        obj.iD = UUID().uuidString
        obj.createdAt = Date()
        return obj as! T
    }
    public func sortDescriptor() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "createdAt", ascending: false)]
    }
}
extension TaskEntityHandler: TaskEntityInteraction {
    public func createTask(on context: NSManagedObjectContext, for title: String, taskDescription: String) {
        let task:CDTask = self.create(context: context)
        task.taskTitle = title
        task.taskDescription = taskDescription
        CoreDataManager.shared.saveWorkingContext(context: context)
    }
    public func updateTask(task iD:String, on context: NSManagedObjectContext, for title: String, taskDescription: String) {
        if let t = self.task(with: iD, context: context) {
            t.taskTitle = title
            t.taskDescription = taskDescription
            CoreDataManager.shared.saveWorkingContext(context: context)
        }
    }
    func task(with id: String, context: NSManagedObjectContext) -> CDTask? {
        let fetchRequest = self.fetchRequest()
        fetchRequest?.predicate = NSPredicate(format: "iD = %@", id)
        
        do {
            let fetchedObject = try context.fetch(fetchRequest!) as! [CDTask]
            return fetchedObject.first
        } catch {
            return nil
        }
    }
    public func delete(task iD: String, on context: NSManagedObjectContext) {
        if let t = self.task(with: iD, context: context) {
            context.delete(t)
            CoreDataManager.shared.saveWorkingContext(context: context)
        }
    }
    public func allTasks(on context: NSManagedObjectContext = CoreDataManager.shared.managedObjectContext) -> [CDTask]? {
        do {
          guard let myFetchRequest = fetchRequest() else { return nil }
          myFetchRequest.sortDescriptors = sortDescriptor()
            let objects = try context.fetch(myFetchRequest)
            return objects as? [CDTask]
        } catch  {
            return nil
        }
    }
}
