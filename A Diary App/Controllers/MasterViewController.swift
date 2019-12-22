//
//  MasterViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/15/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
  
  // MARK: - Properties
  
  let searchController = UISearchController(searchResultsController: nil)
  let managedObjectContext = CoreDataStack().managedObjectContext
  lazy var datasource: MasterDataSource = {
    return MasterDataSource(tableView: self.tableView, managedObjectContext: self.managedObjectContext, fetchRequest: Entry.fetchRequest())
  }()
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var addEntryButton: UIBarButtonItem!
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = datasource
    setupNavBar()
    setupSearchBar()
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    
  }
  
  func setupNavBar() {
    self.title = "Diary App"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ThemeColor.verdigris]
    self.navigationController?.navigationBar.barTintColor = UIColor.ThemeColor.smokyBlack
  }
  
  func setupSearchBar() {
    self.tableView.tableHeaderView = searchController.searchBar
    
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchResultsUpdater = self
  }
  
  // MARK: - Tableview delegate methods
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addEntry" {
      guard let detailViewController = segue.destination as? DetailViewController else { return }
      
      detailViewController.managedObjectContext = self.managedObjectContext
    } else if segue.identifier == "showEntry" {
      guard let displayViewController = segue.destination as? DisplayViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
      
      let entry = datasource.object(at: indexPath)
      displayViewController.entry = entry
      displayViewController.managedObjectContext = self.managedObjectContext
    }
  }
  
}

// MARK: - Search bar results updating method

extension MasterViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    
    if searchText.isEmpty || searchText.count == 0 {
      datasource.fetchedResultsController = EntryFetchedResultsController(managedObjectContext: self.managedObjectContext, tableView: self.tableView, fetchRequest: Entry.fetchRequest())
    } else {
      let request = NSFetchRequest<Entry>(entityName: "Entry")
      let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
      request.sortDescriptors = [sortDescriptor]
      
      let predicate = NSPredicate(format: "title CONTAINS[cd] %@ || content CONTAINS[cd] %@", searchText, searchText)
      request.predicate = predicate
      
      datasource.fetchedResultsController = EntryFetchedResultsController(managedObjectContext: self.managedObjectContext, tableView: self.tableView, fetchRequest: request)
    }
    
    // reloads table view to update results
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
}

