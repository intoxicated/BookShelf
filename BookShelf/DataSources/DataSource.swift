//
//  DatsSource.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

protocol DataSource {
  func find<T>(type: T.Type, query: String) -> [T]
  func update<T>(type: T.Type, id: String, object: T) where T: Copyable
  func remove<T>(type: T.Type, id: String)
  func insert<T>(object: T)
}

