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
    return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
  }
  func urlContent() -> [String: Any]? {
    return nil
  }
}
