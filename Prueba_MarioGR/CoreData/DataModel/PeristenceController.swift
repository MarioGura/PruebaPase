//
//  PeristenceController.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PersistenceDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error cargando Core Data: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
