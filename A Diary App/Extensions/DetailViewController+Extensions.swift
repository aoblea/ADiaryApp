//
//  DetailViewController+Extensions.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/22/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import CoreLocation

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

// MARK: - Text view delegate methods

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

// MARK: - Photo picker manager delegate methods

extension DetailViewController: PhotoPickerManagerDelegate {
  
  func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
    selectedPhoto = image
    manager.dismissPhotoPicker(animated: true, completion: nil)
  }
  
}

// MARK: - Core location manager delegate methods

extension DetailViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = manager.location?.coordinate else { return }
    
    latitude = "\(location.latitude)"
    longitude = "\(location.longitude)"
  }
  
}
