//
//  Storage.swift
//  CoreDataDemo
//
//  Created by Александр on 27.06.2022.
//

import CoreData


class StorageManager {

    static let storageManager = StorageManager()

    let context: NSManagedObjectContext
    
    init() {
        context = persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func save(_ taskName: String, completion: (Task) -> Void) {
     let task = Task(context: context)
        task.title = taskName
        completion(task)
        saveContext()
    }
    
    func delete(_ task: Task) {
        context.delete(task)
        saveContext()
    }
    
    func edit(_ task: Task) {
        saveContext()
    }
}
    
    
    
    
    

    
    
    
    
    
    
    
    

