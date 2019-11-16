//
//  Errors.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Foundation

struct BSError {
  static let linkError = NSError(domain: "data", code: 422, userInfo: nil)
  static let parseError = NSError(domain: "api", code: 400, userInfo: nil)
  static let prepError = NSError(domain: "logic", code: 402, userInfo: nil)
}
