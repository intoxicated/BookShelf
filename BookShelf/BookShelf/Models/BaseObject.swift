//
//  BaseObject.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RealmSwift

protocol Copyable {
  func copyProperties(other: Any?)
}

class BaseObject: Object, Copyable {
  func copyProperties(other: Any?) {
    fatalError("Base object has to be inherited!!")
  }
}
