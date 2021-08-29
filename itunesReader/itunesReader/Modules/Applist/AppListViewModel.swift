//
//  AppListViewModel.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
import UIKit
// Class view Model
class AppListViewModel: NSObject {
    let model = AppListModel()
    func requestData(success: @escaping ()-> Void,
                     failure: @escaping (_ title: String,_ message: String)->Void) {
        model.requestReaderData { (result) in
            let errorText = result.error?.localizedDescription ?? ServiceConstant.fetchError
            return result.isSuccess == true ? success(): failure(AppConstant.name, errorText)
        }
    }
    
    func numberOfRows() -> Int {
        return self.model.appInfoList.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CellViewModel? {
        if let model = self.model.appInfoList[safe: indexPath.row] {
            return CellViewModel(appInfo: model)
        }
        return nil
    }
    
    func requestImage(for indexPath: IndexPath,
                      _ reloadVisibleCell: @escaping(_ indexPaths: [IndexPath])->Void) {
        if self.model.appInfoList[indexPath.row].imageStatus != .downloaded {
            model.requestImage(for: indexPath) { (isSuccess) in
                if isSuccess { reloadVisibleCell([indexPath]) }
            }
        }
    }
    
    func suspendOperatios() {
        model.opQueue.cancelAllOperations()
    }
}
