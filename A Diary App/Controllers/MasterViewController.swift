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
  let managedObjectContext = CoreDataStack().managedObjectContext
  lazy var datasource: MasterDataSource = {
    return MasterDataSource(tableView: self.tableView, managedObjectContext: self.managedObjectContext)
  }()
  
  // MARK: - IBOutlets
  @IBOutlet weak var addEntryButton: UIBarButtonItem!
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = datasource
    setupNavBar()
  }
  
  func setupNavBar() {
    self.title = "Diary App"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ThemeColor.verdigris]
    self.navigationController?.navigationBar.barTintColor = UIColor.ThemeColor.smokyBlack
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



