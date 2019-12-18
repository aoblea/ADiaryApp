//
//  PhotoPickerManager.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/16/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol PhotoPickerManagerDelegate: class {
  func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage)
}

class PhotoPickerManager: NSObject {
  private let imagePickerController = UIImagePickerController()
  private let presentingController: UIViewController
  weak var delegate: PhotoPickerManagerDelegate?
  
  init(presentingViewController: UIViewController) {
    self.presentingController = presentingViewController
    super.init()
    
    configure()
  }
  
  func presentPhotoPicker(animated: Bool) {
    presentingController.present(imagePickerController, animated: animated, completion: nil)
  }
  
  func dismissPhotoPicker(animated: Bool, completion:(() -> Void)?) {
    imagePickerController.dismiss(animated: animated, completion: completion)
  }
  
  private func configure() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      imagePickerController.sourceType = .camera
      imagePickerController.cameraDevice = .rear
    } else {
      imagePickerController.sourceType = .photoLibrary
    }
    
    imagePickerController.mediaTypes = [kUTTypeImage as String]
    
    imagePickerController.delegate = self
  }
}

extension PhotoPickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else { return }
    delegate?.manager(self, didPickImage: image)
  }
}
