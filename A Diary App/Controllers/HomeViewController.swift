//
//  HomeViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/12/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
  
  // MARK: - Properties
  private var entries = [Entry]()

  let writeImage = UIImage(named: "Icn_write")?.withRenderingMode(.alwaysOriginal) // keeps image in original format
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Diary App"
    
    setupSampleModels()
    setupNavBar()
  }
  
  // sample models before core data implementation
  func setupSampleModels() {
    // same entries
    let entry1 = Entry(text: "First entry", creationDate: Date(), photo: nil, emotion: nil)
    let entry2 = Entry(text: "Second entry", creationDate: Date(), photo: nil, emotion: nil)
    let entry3 = Entry(text: "Third entry", creationDate: Date(), photo: nil, emotion: nil)
    
    entries = [entry1, entry2, entry3]
  }
  
  func setupNavBar() {
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    self.navigationController?.navigationBar.barTintColor = .blue
    self.navigationController?.navigationBar.tintColor = .white
  
    let writeBarButton = UIBarButtonItem(image: writeImage, style: .done, target: self, action: #selector(HomeViewController.writeEntry))
    self.navigationItem.rightBarButtonItem = writeBarButton
  }
  
  @objc func writeEntry() {
    print("write entry button pressed.")
    guard let entryViewController = storyboard?.instantiateViewController(identifier: "EntryViewController") as? EntryViewController else { return }
    navigationController?.pushViewController(entryViewController, animated: true)
  }
  

  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // use this to sort by date?
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    let today = dateFormatter.string(from: Date())
    return today
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return entries.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
    
    cell.textLabel?.text = entries[indexPath.row].text
    
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // present entry view controller with cell's details
    guard let entryViewController = storyboard?.instantiateViewController(identifier: "EntryViewController") as? EntryViewController else { return }
    navigationController?.pushViewController(entryViewController, animated: true)
  }

}
