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
  
  func numberofRows() -> Int {
    return self.model.appInfoList.count
  }
  
  func appName(for indexpath: IndexPath) -> String {
    return self.model.appInfoList[indexpath.row].title ?? ""
  }
  
  func appImage(for indexpath: IndexPath) -> Data? {
    return self.model.appInfoList[indexpath.row].imageData
  }
  
  func appDescription(for indexpath: IndexPath) -> String {
    let appInfo = self.model.appInfoList[indexpath.row]
    return "Created by: \(String(describing: appInfo.artistName ?? "")) \nCopyRight: \(String(describing: appInfo.copyRight ?? ""))"
  }
  
  func requestImage(for indexpath: IndexPath,
                    _ reloadVisibleCell: @escaping(_ indexPaths: [IndexPath])->Void) {
    if self.model.appInfoList[indexpath.row].imageStatus != .Downloaded {
      model.requestImage(for: indexpath) { (isSucess) in
        if isSucess { reloadVisibleCell([indexpath]) }
      }
    }
  }
  
  func suspendOperatios() {
    model.opQueue.cancelAllOperations()
  }
}
