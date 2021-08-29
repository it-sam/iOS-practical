//
//  AppListModel.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
class AppListModel: NSObject {
    // lazy variable use
    lazy var appInfoList: [AppInfo] = []
    lazy var request = RequestHandler.shared
    lazy var opQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        return queue }()
    
    // Actual fetch request to get list of apps
    func requestReaderData(_ result: @escaping (Result<Bool>)-> Void) {
        let readerRequest = ReaderRequest()
        request.makePostRequest(readerRequest) { (requestResult) in
            if requestResult.isSuccess, let data = requestResult.value as? Data {
                JsonParser.parse(data, { (res: Result<AppListContainer>) in
                    if res.isSuccess, let appList = res.value?.appList {
                        self.appInfoList = appList
                        result(Result.success(true))
                    } else {
                        result(Result.failure(res.error!))
                    }
                })
            } else {
                result(Result.failure(requestResult.error!))
            }
        }
    }
    
    // Image request to fetch image of index
    // operationQueue handling
    func requestImage(for indexPath:IndexPath,
                      _ result: @escaping (Bool)-> Void) {
        let imageDownloader = ImageDownloader(self.appInfoList[indexPath.row].imageUrl, indexPath: indexPath) { [weak self] indexPath, photoStatus, data in
            if let record = self?.appInfoList[safe: indexPath.row] {
                if data != nil {
                    record.imageData = data
                }
                record.imageStatus = photoStatus
            }
            result(true)
        }
        opQueue.addOperation(imageDownloader)
    }
}
