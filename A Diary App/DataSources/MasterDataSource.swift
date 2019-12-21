//
//  MasterDataSource.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/20/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import CoreData

class MasterDataSource: NSObject, UITableViewDataSource {
  
  // MARK: - Properties
  private let tableView: UITableView
  private let managedObjectContext: NSManagedObjectContext
  let dateFormatter = DateFormatter()
  
  lazy var fetchedResultsController: EntryFetchedResultsController = {
    return EntryFetchedResultsController(managedObjectContext: self.managedObjectContext, tableView: self.tableView)
  }()
  
  // MARK: - Init
  init(tableView: UITableView, managedObjectContext: NSManagedObjectContext) {
    self.tableView = tableView
    self.managedObjectContext = managedObjectContext
  }

  // MARK: - Tableview data source methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsController.sections?.count ?? 0
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let section = fetchedResultsController.sections?[section] else { return 0 }
    return section.numberOfObjects
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let entry = fetchedResultsController.object(at: indexPath)
    managedObjectContext.delete(entry)
    managedObjectContext.saveChanges()
  }
  
  // TODO: - Create a view model using masterviewcell to create cleaner code

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! MasterViewCell
    return configureCell(cell, at: indexPath)
  }
  
  private func configureCell(_ cell: MasterViewCell, at indexPath: IndexPath) -> UITableViewCell {
    let entry = fetchedResultsController.object(at: indexPath)
    
    cell.titleLabel.text = entry.title
    
    dateFormatter.dateFormat = "EEEE d MMMM"
    let formattedDate = dateFormatter.string(from: entry.creationDate)
    cell.creationDateLabel.text = formattedDate
    
    if entry.emotion == nil {
      cell.emotionImageView.isHidden = true
    } else {
      cell.emotionImageView.isHidden = false
      cell.emotionImageView.image = entry.emoteImage
    }
    
    if entry.photo == nil {
      cell.entryImageView.image = UIImage(named: "icn_noimage")
    } else {
      cell.entryImageView.image = entry.photoImage
    }
    
    if entry.latitude == nil && entry.longitude == nil {
      cell.locationLabel.text = "Location unavailable"
    } else {
      if let entryLatitude = entry.latitude, let entryLongitude = entry.longitude {
        cell.locationLabel.text = "Lat: \(entryLatitude), Long: \(entryLongitude)"
      }
    }
    
    return cell
  }
  
  // MARK: - Helper methods
  func object(at indexPath: IndexPath) -> Entry {
    return fetchedResultsController.object(at: indexPath)
  }
}
