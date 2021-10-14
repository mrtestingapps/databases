//
//  Helper.swift
//  GetirTodo
//
//  Created by Afzal Murtaza on 05/09/2021.
//

import Foundation
import CoreData

public class NSFetchedResultsControllerHelper {
    public static func getFetchResult(request: NSFetchRequest<NSFetchRequestResult>,context: NSManagedObjectContext,delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<NSFetchRequestResult>?{
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = delegate
        do {
            try controller.performFetch()
        } catch  {
            print(error)
        }
        return controller
    }
}
