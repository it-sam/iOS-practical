//
//  ImageDownloader.swift
//  itunesReader
//
//  Created by Shyam Parmar on 18/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
typealias onComplete = (IndexPath, photoStatus, Data? ) -> Void
// subclass use of Operation
class ImageDownloader: Operation {
    var imageUrl: String?
    var onFinish: onComplete
    var indexPath: IndexPath
    // overriding of methods and variables
    override var isAsynchronous: Bool { get { return true }}
    public init(_ url: String?, indexPath: IndexPath, onComplete:  @escaping onComplete) {
        self.imageUrl = url
        self.indexPath = indexPath
        self.onFinish = onComplete
    }
    
    // overriding of methods and variables
    public override func main() {
        if let imageUrl = self.imageUrl,
           let url = URL(string: imageUrl) {
            do {
                let data = try Data(contentsOf: url)
                onFinish(indexPath, .downloaded, data)
            } catch {
                onFinish(indexPath, .failed, nil)
            }
        } else {
            onFinish(indexPath, .failed, nil)
        }
    }
}
