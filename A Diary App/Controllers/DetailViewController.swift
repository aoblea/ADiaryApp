//
//  DetailViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/15/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

// TODO: - For titleTextField, I can limit the number of characters that can be entered.

// This controller will be used to create entries.
class DetailViewController: UIViewController {
  
  // MARK: - Properties
  
  let today = Date()
  let dateFormatter = DateFormatter()
  weak var delegate: MasterViewController?
  
  var selectedEmote: UIImage?
  let goodEmoteImage = UIImage(named: "icn_happy")
  let averageEmoteImage = UIImage(named: "icn_average")
  let badEmoteImage = UIImage(named: "icn_bad")
  
  var selectedPhoto: UIImage?
  
  lazy var photoPickerManager: PhotoPickerManager = {
    let manager = PhotoPickerManager(presentingViewController: self)
    manager.delegate = self
    return manager
  }()
  
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
    
    // Do any additional setup after loading the view.
  }
  
  func setupPhotoPicker() {
    addPhoto.addTarget(self, action: #selector(launchCamera), for: .touchUpInside)
  }
  
  @objc func launchCamera() {
    photoPickerManager.presentPhotoPicker(animated: true)
  }
  
  // this method should take today's date whenever creating a new entry
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
  

  @IBAction func saveEntry(_ sender: UIBarButtonItem) {
    // save entry
    guard let title = titleTextField.text, let content = contentTextView.text else { return }

    if title.isEmpty || content.isEmpty {
      print("Cannot save entry with an empty title and/or content")
    } else {
      
      
      let newEntry = Entry(title: title, content: content, creationDate: today, emotion: selectedEmote, photo: selectedPhoto)
      delegate?.add(with: newEntry)
      
      self.navigationController?.popViewController(animated: true)
    }
    
    
  }
  

}


// MARK: - Emotion buttons selection methods

extension DetailViewController {
  @objc func goodButtonPressed() {
    determineGoodSelection()
  }
  
  func determineGoodSelection() {
    goodButton.isSelected = !goodButton.isSelected
    if goodButton.isSelected {
      print("good selected")
      goodButton.alpha = 0.5
      
      if averageButton.isSelected == true {
        determineAverageSelection()
      } else if badButton.isSelected == true {
        determineBadSelection()
      }
      
      selectedEmote = goodEmoteImage
    } else {
      print("good unselected")
      goodButton.alpha = 1.0
      selectedEmote = nil
    }
  }
  
  @objc func averageButtonPressed() {
    determineAverageSelection()
  }
  
  func determineAverageSelection() {
    averageButton.isSelected = !averageButton.isSelected
    if averageButton.isSelected {
      print("average selected")
      averageButton.alpha = 0.5
      
      if goodButton.isSelected == true {
        determineGoodSelection()
      } else if badButton.isSelected == true {
        determineBadSelection()
      }
      
      selectedEmote = averageEmoteImage
    } else {
      print("average unselected")
      averageButton.alpha = 1.0
      selectedEmote = nil
    }
  }
  
  @objc func badButtonPressed() {
    determineBadSelection()
  }
  
  func determineBadSelection() {
    badButton.isSelected = !badButton.isSelected
    if badButton.isSelected {
      print("bad selected")
      badButton.alpha = 0.5
      
      if goodButton.isSelected == true {
        determineGoodSelection()
      } else if averageButton.isSelected == true {
        determineAverageSelection()
      }
      
      selectedEmote = badEmoteImage
    } else {
      print("bad unselected")
      badButton.alpha = 1.0
      selectedEmote = nil
    }
  }
  
}

// MARK: Text view delegate methods

extension DetailViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = .black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
          textView.text = "Write more about your day here."
          textView.textColor = .lightGray
      }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText = textView.text ?? ""
    guard let textRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: textRange, with: text)

    contentLimitLabel.text = "\(updatedText.count)/200"

    return updatedText.count < 200
  }
}

extension DetailViewController: PhotoPickerManagerDelegate {
  func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
    selectedPhoto = image
    manager.dismissPhotoPicker(animated: true, completion: nil)
  }
}
