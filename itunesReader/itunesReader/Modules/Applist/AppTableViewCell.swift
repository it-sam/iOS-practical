//
//  AppTableViewCell.swift
//  itunesReader
//
//  Created by Shyam Parmar on 07/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
// custom UITableViewCell
class AppTableViewCell: UITableViewCell {
  @IBOutlet weak var appTitle: UILabel!
  @IBOutlet weak var appDescription: UILabel!
  @IBOutlet weak var appImage: UIImageView!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  public func setImage(_ data: Data) {
    self.appImage.image = UIImage(data: data)
    self.appImage.layer.cornerRadius = 8
    self.appImage.layer.masksToBounds = true
    self.loadingIndicator.stopAnimating()
  }
}
