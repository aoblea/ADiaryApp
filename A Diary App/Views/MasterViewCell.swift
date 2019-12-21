//
//  MasterViewCell.swift
//  A Diary App
//
//  Created by Arwin Oblea on 12/15/19.
//  Copyright © 2019 Arwin Oblea. All rights reserved.
//

import UIKit

class MasterViewCell: UITableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var entryImageView: UIImageView!
  @IBOutlet weak var creationDateLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var emotionImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
