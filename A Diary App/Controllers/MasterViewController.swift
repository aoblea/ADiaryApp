//
//  MasterViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/15/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  
  // MARK: - Properties
  
  var entries = [Entry]()
  let dateFormatter = DateFormatter()
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var addEntryButton: UIBarButtonItem!
  
  // MARK: - Viewdidload

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()

  }
  
  func setupNavBar() {
    self.title = "Diary App"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ThemeColor.verdigris]
    self.navigationController?.navigationBar.barTintColor = UIColor.ThemeColor.smokyBlack
  }
  

  
  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return entries.count
  }
  
  // TODO: - Create a view model using masterviewcell to create cleaner code

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! MasterViewCell
    cell.titleLabel.text = entry(from: indexPath).title
    
    dateFormatter.dateFormat = "EEEE d MMMM"
    let formattedDate = dateFormatter.string(from: entry(from: indexPath).creationDate)
    cell.creationDateLabel.text = formattedDate
    
    if entry(from: indexPath).emotion == nil {
      cell.emotionImageView.isHidden = true
    } else {
      cell.emotionImageView.isHidden = false
      cell.emotionImageView.image = entry(from: indexPath).emotion
    }
    
    // TODO: Setup photo image view, geo location label
    if entry(from: indexPath).photo == nil {
      cell.entryImageView.image = UIImage(named: "icn_noimage")
    } else {
      cell.entryImageView.image = entry(from: indexPath).photo
    }
    
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  // MARK: - Helper methods
  
  func entry(from indexPath: IndexPath) -> Entry {
    return entries[indexPath.row]
  }
  
  func add(with newEntry: Entry) {
    entries.append(newEntry)
    tableView.reloadData()
  }
  

  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addEntry" {
      let destination = segue.destination as? DetailViewController
      destination?.delegate = self
    }
  }
  
}
