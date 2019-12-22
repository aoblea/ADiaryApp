//
//  DetailViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/15/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

// This controller will be used to create entries.
class DetailViewController: UIViewController {
  
  // MARK: - Properties
  
  let dateFormatter = DateFormatter()
  let today = Date()
  
  var selectedEmote: UIImage?
  let goodEmoteImage = UIImage(named: "icn_happy")
  let averageEmoteImage = UIImage(named: "icn_average")
  let badEmoteImage = UIImage(named: "icn_bad")

  var latitude: String?
  var longitude: String?
  let locationManager = CLLocationManager()
  
  var selectedPhoto: UIImage?
  lazy var photoPickerManager: PhotoPickerManager = {
    let manager = PhotoPickerManager(presentingViewController: self)
    manager.delegate = self
    return manager
  }()
  
  var entry: Entry?
  var managedObjectContext: NSManagedObjectContext!
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var contentTextView: UITextView!
  @IBOutlet weak var contentLimitLabel: UILabel!
  @IBOutlet weak var addPhoto: UIButton!
  @IBOutlet weak var goodButton: UIButton! {
    didSet {
      self.goodButton.isSelected = false
    }
  }
  @IBOutlet weak var averageButton: UIButton! {
    didSet {
      self.averageButton.isSelected = false
    }
  }
  @IBOutlet weak var badButton: UIButton! {
    didSet {
      self.badButton.isSelected = false
    }
  }
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupEmoteButtons()
    setupContentTextView()
    setupTitle()
    setupPhotoPicker()
    
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      setupLocationManager()
    } else {
      // request permission again
      locationManager.requestWhenInUseAuthorization()
    }
    
    // if entry exists, we are in editing mode
    if let entry = entry {
      self.titleTextField.text = entry.title
      self.contentTextView.text = entry.content
      self.selectedEmote = entry.emoteImage
      self.selectedPhoto = entry.photoImage
      self.latitude = entry.latitude
      self.longitude = entry.longitude
    }
    
  }
  
  // MARK: - Viewdidappear
  
  override func viewDidAppear(_ animated: Bool) {
    if CLLocationManager.authorizationStatus() == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  }
  
  func setupPhotoPicker() {
    addPhoto.addTarget(self, action: #selector(launchCamera), for: .touchUpInside)
  }
  
  @objc func launchCamera() {
    photoPickerManager.presentPhotoPicker(animated: true)
  }
  
  // this method should take today's date whenever creating a new entry/updating an existing entry
  func setupTitle() {
    dateFormatter.dateStyle = .medium
    let formattedDate = dateFormatter.string(from: today)
    title = formattedDate
  }
    
  func setupUI() {
    view.backgroundColor = UIColor.ThemeColor.russianViolet
    contentLimitLabel.textColor = UIColor.ThemeColor.lavendarGray
    self.navigationController?.navigationBar.tintColor = UIColor.ThemeColor.verdigris
  }
  
  func setupEmoteButtons() {
    goodButton.addTarget(self, action: #selector(goodButtonPressed), for: .touchUpInside)
    averageButton.addTarget(self, action: #selector(averageButtonPressed), for: .touchUpInside)
    badButton.addTarget(self, action: #selector(badButtonPressed), for: .touchUpInside)
  }
  
  func setupContentTextView() {
    contentTextView.delegate = self
    contentTextView.text = "Write more about your day here."
    contentTextView.textColor = .lightGray
  }

  // MARK: - Save bar button method
  
  @IBAction func saveEntry(_ sender: UIBarButtonItem) {
    guard let title = titleTextField.text, let content = contentTextView.text else { return }

    if title.count >= 20 {
      self.presentAlert(error: .exceedsCharacterLimit)
    } else if title.isEmpty || content.isEmpty {
      self.presentAlert(error: .emptyInformation)
    } else {
      if let updatedEntry = entry {
        // update existing entry
        updatedEntry.title = title
        updatedEntry.content = content
        updatedEntry.creationDate = today
        updatedEntry.emotion = selectedEmote?.jpegData(compressionQuality: 1.0)
        updatedEntry.photo = selectedPhoto?.jpegData(compressionQuality: 1.0)
        updatedEntry.latitude = latitude?.description
        updatedEntry.longitude = longitude?.description
        
        managedObjectContext.saveChanges()
        
        locationManager.stopUpdatingLocation()
        navigationController?.popToRootViewController(animated: true)
      } else {
        // creating a new entry
        let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: managedObjectContext) as! Entry
        entry.title = title
        entry.content = content
        entry.creationDate = today
        entry.emotion = selectedEmote?.jpegData(compressionQuality: 1.0)
        entry.photo = selectedPhoto?.jpegData(compressionQuality: 1.0)
        entry.latitude = latitude?.description
        entry.longitude = longitude?.description

        managedObjectContext.saveChanges()

        locationManager.stopUpdatingLocation()
        navigationController?.popToRootViewController(animated: true)
      }
    }
  }
  
}


