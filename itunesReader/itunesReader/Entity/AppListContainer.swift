//
//  AppListContainer.swift
//  itunesReader
//
//  Created by Shyam Parmar on 14/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
// Entity
// decodable and decoder use
class AppListContainer: Decodable {
  var appList :[AppInfo]? = nil
  
  enum FeedCodingKeys: String, CodingKey {
    case feed
  }
  enum resultCodingKeys: String, CodingKey {
    case results
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: FeedCodingKeys.self)
    let feed = try container.nestedContainer(keyedBy: resultCodingKeys.self, forKey: .feed)
    self.appList = try feed.decodeIfPresent([AppInfo].self, forKey: .results)
  }
}
