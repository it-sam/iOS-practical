//
//  AppListRequest.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation

class ReaderRequest: IRequest {
    
  func urlPath() -> String {
    return "https://www.dropbox.com/s/c3f798yq4po9tq9/itunesData.json?dl=1"
  }
    
  func urlContent() -> [String: Any]? {
    return nil
  }
}
