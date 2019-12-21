//
//  Entry+CoreDataProperties.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/19/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Entry: NSManagedObject {
  
}

extension Entry {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
    let request = NSFetchRequest<Entry>(entityName: "Entry")
    let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
    request.sortDescriptors = [sortDescriptor]

    return request
  }

  @NSManaged public var content: String
  @NSManaged public var creationDate: Date
  @NSManaged public var emotion: Data?
  @NSManaged public var latitude: String?
  @NSManaged public var longitude: String?
  @NSManaged public var photo: Data?
  @NSManaged public var title: String

}

extension Entry {
  var photoImage: UIImage {
    if let photo = self.photo {
      return UIImage(data: photo)!
    } else {
      return UIImage(named: "icn_noimage")!
    }
  }
  
  var emoteImage: UIImage? {
    if let emote = self.emotion {
      return UIImage(data: emote)!
    } else {
      return nil
    }
  }
  
}
