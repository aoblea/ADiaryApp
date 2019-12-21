//
//  CoreDataStack.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/19/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  lazy var managedObjectContext: NSManagedObjectContext = {
    let container = self.persistentContainer
    return container.viewContext
  }()
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Entry")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error: \(error), \(error.userInfo)")
      }
      
      storeDescription.shouldInferMappingModelAutomatically = true
      storeDescription.shouldMigrateStoreAutomatically = true
    }
    
    return container
  }()
}

extension NSManagedObjectContext {
  func saveChanges() {
    if self.hasChanges {
      do {
        try save()
      } catch {
        fatalError("Error: \(error.localizedDescription)")
      }
    }
  }
}
