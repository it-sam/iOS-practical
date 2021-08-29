//
//  CellViewModel.swift
//  itunesReader
//
//  Created by Shyam Parmar on 28/8/21.
//  Copyright © 2021 FreeWare. All rights reserved.
//

import Foundation

class CellViewModel: NSObject {
    private let appInfo: AppInfo
    init(appInfo: AppInfo) {
        self.appInfo = appInfo
        super.init()
    }
}

extension CellViewModel {
    var appDescription: String {
        return "Created by: \(String(describing: appInfo.artistName ?? "")) \nCopyRight: \(String(describing: appInfo.copyRight ?? ""))"
    }
    
    var title: String {
        return self.appInfo.title ?? ""
    }
    
    var image: Data? {
        return appInfo.imageData
    }
    
    var isFailToDownload: Bool {
        return appInfo.imageStatus == .failed
    }
}
