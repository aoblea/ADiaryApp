//
//  EntryViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/12/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var addPhotoButton: UIButton!
  @IBOutlet weak var addLocationButton: UIButton!
  @IBOutlet weak var badEmoteButton: UIButton!
  @IBOutlet weak var averageEmoteButton: UIButton!
  @IBOutlet weak var goodEmoteButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!

  @IBOutlet weak var textLimitLabel: UILabel!

  // MARK: - Properties
  private var entry: Entry?
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    let today = dateFormatter.string(from: Date())
    
    self.title = today
    setupNavBar()
  }
  
  func formatDate() {

  }
    
  func setupNavBar() {
    let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(EntryViewController.saveEntry))
    navigationItem.rightBarButtonItem = saveBarButton
  }
  
  @objc func saveEntry() {
    print("save entry button pressed.")
  }

}
