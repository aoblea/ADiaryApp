//
//  EntryFetchedResultsController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/19/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import CoreData

class EntryFetchedResultsController: NSFetchedResultsController<Entry>, NSFetchedResultsControllerDelegate {
  
  private let tableView: UITableView
  
  init(managedObjectContext: NSManagedObjectContext, tableView: UITableView, fetchRequest: NSFetchRequest<Entry>) {
    self.tableView = tableView
    super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
      
    self.delegate = self
    
    tryFetch()
  }
    
  func tryFetch() {
    do {
      try performFetch()
    } catch {
      print("Unresolved error: \(error.localizedDescription)")
    }
  }
  
  // MARK: - Fetched results controller delegate
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      guard let newIndexPath =  newIndexPath else { return }
      tableView.insertRows(at: [newIndexPath], with: .automatic)
    case .delete:
      guard let indexPath = indexPath else { return }
      tableView.deleteRows(at: [indexPath], with: .automatic)
    case .update, .move:
      guard let indexPath = indexPath else { return }
      tableView.reloadRows(at: [indexPath], with: .automatic)
    @unknown default:
      return
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
}
