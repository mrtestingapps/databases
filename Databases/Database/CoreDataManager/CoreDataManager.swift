//
//  CoreDataManager.swift
//  GetirTodo
//
//  Created by Afzal Murtaza on 05/09/2021.
//

import Foundation
import CoreData

public class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    public var managedObjectContext: NSManagedObjectContext { get {
        return self.persistentContainer.viewContext
        }
    }
    
    public var workingContext: NSManagedObjectContext { get {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.managedObjectContext
        return context
        }
    }
        
    // MARK: - Loading containter...
    
    lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: "Gitr", withExtension:"momd") else {
                fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let container = NSPersistentContainer(name: "Gitr", managedObjectModel: mom)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        return container
    }()
    
    func saveContext () {
        self.managedObjectContext.performAndWait {
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                    print("Main context saved")
                } catch {
                    print(error)
                }
            }
        }
        
    }
    // MARK: - Core Data Saving support

    func saveWorkingContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            saveContext()
        } catch (let error) {
            print(error)
        }
    }
    
    
}
