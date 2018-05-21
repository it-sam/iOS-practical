//
//  AppError.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
//independent Error creator class
class AppError: NSObject {
  static func create(_ message: String) -> Error {
    return NSError(domain: AppConstant.name, code: 111,
                     userInfo: [NSLocalizedDescriptionKey: message])
  }
}
