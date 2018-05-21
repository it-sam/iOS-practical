//
//  AppInfo.swift
//  itunesReader
//
//  Created by Shyam Parmar on 14/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import UIKit
// enum creation and use
enum photoStatus {
  case new, failed, Downloaded
}
// decodable and decoder use
class AppInfo: Decodable {
  
  public var title: String?
  public var imageUrl: String?
  public var appUrl: String?
  public var imageData: Data?
  public var artistName: String?
  public var copyRight: String?
  public var imageStatus = photoStatus.new
  
  enum CodingKeys: String, CodingKey {
    case name
    case imageUrl = "artworkUrl100"
    case appUrl = "url"
    case artistName = "artistName"
    case copyRight = "copyright"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.title = try container.decodeIfPresent(String.self, forKey: .name)
    self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    self.appUrl = try container.decodeIfPresent(String.self, forKey: .appUrl)
    self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
    self.copyRight = try container.decodeIfPresent(String.self, forKey: .copyRight)
  }
}
