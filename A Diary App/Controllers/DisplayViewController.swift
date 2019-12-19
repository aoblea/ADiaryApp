//
//  DisplayViewController.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/15/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit
import MapKit

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
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupMap()
    
  }
  
  // MARK: - Helper methods
  
  func setupUI() {
    if entry?.photo == nil {
      photoImageView.image = UIImage(named: "icn_noimage")
    } else {
      photoImageView.image = entry?.photo
    }
    
    emoteImageView.image = entry?.emotion
    titleLabel.text = entry?.title
    dateLabel.text = entry?.creationDate.description
    contentTextView.text = entry?.content
  }
  
  func setupMap() {
    if let lat = entry?.latitude, let long = entry?.longitude {
      let coordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
      
      let radius: CLLocationDistance = 1000
      let span = MKCoordinateRegion(center: coordinate2D, latitudinalMeters: radius, longitudinalMeters: radius).span
      let region = MKCoordinateRegion(center: coordinate2D, span: span)
      mapView.setRegion(region, animated: true)
    }
    
  }

}
