//
//  Array+Extension.swift
//  itunesReader
//
//  Created by Shyam Parmar on 28/8/21.
//  Copyright © 2021 FreeWare. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        return (index >= 0 && index < endIndex) ? self[index] : nil
    }
}
