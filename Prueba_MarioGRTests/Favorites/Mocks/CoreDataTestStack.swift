//
//  CoreDataTestStack.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import CoreData

final class CoreDataTestStack {

    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "PersistenceDataModel")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        persistentContainer.persistentStoreDescriptions = [description]

        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading test store: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
