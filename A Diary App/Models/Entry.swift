//
//  Entry.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/12/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

class Entry {
  let text: String
  let creationDate: Date
  var photo: UIImage?
  var emotion: String?
//  var location: String? for core location implementation
  
  init(text: String, creationDate: Date, photo: UIImage?, emotion: String?) {
    self.text = text
    self.creationDate = creationDate
    self.photo = photo
    self.emotion = emotion
  }
}
