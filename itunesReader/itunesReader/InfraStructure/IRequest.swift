//
//  IRequest.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
//protocol use in swift
protocol IRequest {
  func urlPath() -> String
  func urlContent() -> [String: Any]?
}
