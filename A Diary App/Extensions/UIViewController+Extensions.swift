//
//  UIViewController+Extensions.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/20/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func presentAlert(error: EntryError) {
    let title: String
    let message: String
    
    switch error {
    case .emptyInformation:
      title = "Insufficient Details"
      message = "Cannot save with empty textfields."
    case .exceedsCharacterLimit:
      title = "Exceeded Limit"
      message = "Cannot exceed over 20 characters."
    }
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alert = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(alert)
    
    self.present(alertController, animated: true)
  }
  
}
