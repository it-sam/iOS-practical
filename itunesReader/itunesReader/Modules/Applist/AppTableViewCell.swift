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
   static var identifier = "AppTableCell"
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
}

///
extension AppTableViewCell {
    private func resetCell() {
        self.appTitle.text = nil
        self.appDescription.text = nil
        self.appImage.image = nil
        self.appImage.layer.cornerRadius = 8
        self.appImage.layer.masksToBounds = true
    }
    
    func updateWithModel(model: CellViewModel) {
        self.resetCell()
        //
        self.appTitle.text = model.title
        self.appDescription.text = model.appDescription
        self.loadingIndicator.startAnimating()
        if let data = model.image {
            self.setImage(data)
        }
        else if model.isFailToDownload {
            self.setDownloadingFailImage()
        }
    }
    
    private func setImage(_ data: Data) {
        UIView.transition(with: self.appImage,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.appImage.image = UIImage(data: data)
                          }, completion: nil)
        self.loadingIndicator.stopAnimating()
    }
    
    public func setDownloadingFailImage() {
        self.loadingIndicator.stopAnimating()
        self.appImage.image = UIImage(named: "downloading_failed")
    }
}
