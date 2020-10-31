//
//  ImageDownloader.swift
//  itunesReader
//
//  Created by Shyam Parmar on 18/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
// subclass use of Operation
class ImageDownloader: Operation {
  var imageRecord: AppInfo
  // overriding of methods and variables
  override var isAsynchronous: Bool { get { return true }}
  
  public init(_ record: AppInfo) {
    self.imageRecord = record
  }
  // overriding of methods and variables
  public override func main() {
    if let imageUrl = self.imageRecord.imageUrl,
       let url = URL(string: imageUrl) {
        do {
          let data = try Data(contentsOf: url)
          self.imageRecord.imageData = data
          self.imageRecord.imageStatus = .Downloaded
        } catch {
          self.imageRecord.imageStatus = .failed
          print("Fail to download image")
        }
    } else {
        self.imageRecord.imageStatus = .failed
        print("Fail to download image")
    }
  }
}
