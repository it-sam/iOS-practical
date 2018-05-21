//
//  JsonParser.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
// Independent Json parse
// generics use
class JsonParser {
  static func parse<T: Decodable>(_ data: Data, _ result: @escaping(Result<T>) -> Void) {
    let decoder  = JSONDecoder()
    do {
      let todo: T = try decoder.decode(T.self, from: data as Data)
      result(Result.success(todo))
    } catch {
      let error = AppError.create("Json deserilization failed.")
      result(Result.failure(error))
    }
  }
}
