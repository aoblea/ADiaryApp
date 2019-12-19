//
//  Entry.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/12/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

// Model used before implementing core data
class Entry {
  var title: String
  var content: String
  var creationDate: Date
  var emotion: UIImage?
  var photo: UIImage?
  var latitude: Double?
  var longitude: Double?
  
  init(title: String, content: String, creationDate: Date, emotion: UIImage?, photo: UIImage?, latitude: Double?, longitude: Double?) {
    self.title = title
    self.content = content
    self.creationDate = creationDate
    self.emotion = emotion
    self.photo = photo
    self.latitude = latitude
    self.longitude = longitude
  }
}
