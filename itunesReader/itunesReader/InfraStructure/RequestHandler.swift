//
//  RequestHandler.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation

//typeAlias responseHandler = (Any?, Error?) -> Void

// request handler - use of Url session
class RequestHandler: NSObject {
  class var shared :RequestHandler {
    struct Singleton {
      static let instance = RequestHandler()
    }
    return Singleton.instance
  }
  
  func makePostRequest(_ request: IRequest, _ resultHandler: @escaping (Result<Any>)-> Void) {
    let url = request.urlPath()
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 60
    let urlSession = URLSession(configuration: sessionConfig)
    
    let task = urlSession.dataTask(with: URLRequest(url: URL(string: url)!))
    { (data, response, error) in
      guard error == nil else {
        let err = AppError.create(error!.localizedDescription)
        return resultHandler(Result.failure(err))
      }
      guard let responseData = data else {
        print("Error: did not receive data")
        let err = AppError.create("did not receive data")
        return resultHandler(Result.failure(err))
      }
      resultHandler(Result.success(responseData))
    }
    task.resume()
  }
}
