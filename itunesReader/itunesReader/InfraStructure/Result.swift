//
//  Result.swift
//  itunesReader
//
//  Created by Shyam Parmar on 13/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import Foundation
// generics
public enum Result<Value> {
  case success(Value)
  case failure(Error)
  
  public var isSuccess: Bool {
    return value != nil ? true: false
  }
  public var value: Value? {
    switch self {
    case .success(let value):
      return value
    case .failure:
      return nil
    }
  }
  public var error: Error? {
    switch self {
    case .success:
      return nil
    case .failure(let error):
      return error
    }
  }
}
