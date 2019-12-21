//
//  DisplayViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/15/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import MapKit
import CoreData

// This controller will be used to preview cell's information. An edit button will be used to change any information.
class DisplayViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var emoteImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var contentTextView: UITextView!
  
  // MARK: - Properties
  var entry: Entry?
  var managedObjectContext: NSManagedObjectContext!
  let dateFormatter = DateFormatter()
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupMap()
  }
  
  // MARK: - Helper methods
  func setupUI() {
    view.backgroundColor = UIColor.ThemeColor.russianViolet
    titleLabel.textColor = UIColor.ThemeColor.paradisePink
    contentTextView.textColor = UIColor.ThemeColor.paradisePink
    contentTextView.backgroundColor = UIColor.ThemeColor.smokyBlack
    
    if entry?.photo == nil {
      photoImageView.image = UIImage(named: "icn_noimage")
    } else {
      photoImageView.image = entry?.photoImage
    }
    
    emoteImageView.image = entry?.emoteImage
    titleLabel.text = entry?.title
    
    if let entryDate = entry?.creationDate {
      dateFormatter.dateStyle = .short
      let formattedDate = dateFormatter.string(from: entryDate)
      dateLabel.text = "Last updated: \(formattedDate)"
    }
   
    contentTextView.text = entry?.content
  }
  
  func setupMap() {
    if let lat = entry?.latitude, let long = entry?.longitude {
      let doubleLat = Double(lat)
      let doubleLong = Double(long)
      
      let coordinate2D = CLLocationCoordinate2D(latitude: doubleLat!, longitude: doubleLong!)
      
      let radius: CLLocationDistance = 1000
      let span = MKCoordinateRegion(center: coordinate2D, latitudinalMeters: radius, longitudinalMeters: radius).span
      let region = MKCoordinateRegion(center: coordinate2D, span: span)
      mapView.setRegion(region, animated: true)
    }
    
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editEntry" {
      guard let detailViewController = segue.destination as? DetailViewController else { return }
      
      detailViewController.entry = entry
      detailViewController.managedObjectContext = self.managedObjectContext
    }
  }

}

