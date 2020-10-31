//
//  AppAlert.swift
//  itunesReader
//
//  Created by Shyam Parmar on 20/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
import UIKit

class AppAlert {
  static func Alert (_ title: String, _ message: String) -> UIAlertController {
    // create the alert
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: UIAlertController.Style.alert)
    return alert
  }
  
  static func addOtherButton(_ alert: UIAlertController,
                             _ otherBtnTitle: String,
                             _ otherBtnHandler: (()-> Void)? = nil) -> UIAlertController {
    
    let otherBtnAction = UIAlertAction(title: otherBtnTitle, style: .destructive) { (_) in
      otherBtnHandler?()
    }
    alert.addAction(otherBtnAction)
    return alert
  }
  
  static func addCancelButton(_ alert: UIAlertController,
                              _ cancelBtnTitle: String,
                              _ cancelHandler: (()-> Void)? = nil) -> UIAlertController {
    let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .cancel){ (_) in
      cancelHandler?()
    }
    alert.addAction(cancelAction)
    return alert
  }
}
