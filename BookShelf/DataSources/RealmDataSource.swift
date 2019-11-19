//
//  RealmDataSource.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RealmSwift

struct RealmDataSource: DataSource {
  func find<T>(type: T.Type, query: String) -> [T] {
    guard let t = type as? Object.Type else {
      fatalError("type has to be inheried from Object")
    }
    return self.getObjects(type: t, query: query) as? [T] ?? []
  }
  
  func remove<T>(type: T.Type, id: String) {
    guard let t = type as? Object.Type else {
      fatalError("type has to be inheried from Object")
    }
    self.removeObject(type: t, id: id)
  }
  
  func update<T>(type: T.Type, id: String, object: T) where T: Copyable {
    guard let t = type as? BaseObject.Type, let obj = object as? BaseObject else {
      fatalError("type has to be inheried from BaseObject")
    }
    self.updateObject(type: t, id: id, object: obj)
  }
  
  func insert<T>(object: T) {
    guard let object = object as? Object else {
      fatalError("type has to be inheried from Object")
    }
    self.insertObject(object: object)
  }
  
  private var realm = try? Realm.safeInit()
  
  private func getObjects<T: Object>(type: T.Type, query: String) -> [T] {
    guard let realm = self.realm else { return [] }
    let queryResult = realm.objects(type).filter(query)
    var result: [T] = []
    for item in queryResult {
      result.append(item)
    }
    
    return result
  }
  
  private func removeObject<T: Object>(type: T.Type, id: String) {
    try? self.realm?.safeWrite {
      let item = self.realm?.object(ofType: type, forPrimaryKey: id)
      if item?.isInvalidated == false, let item = item {
        self.realm?.delete(item)
      }
    }
  }
  
  private func insertObject<T: Object>(object: T) {
    try? self.realm?.safeWrite {
      self.realm?.add(object)
    }
  }
  
  private func updateObject<T>(type: T.Type, id: String, object: T) where T: Object & Copyable {
    try? self.realm?.safeWrite {
      let item = self.realm?.object(ofType: type, forPrimaryKey: id)
      if item?.isInvalidated == false, let item = item {
        item.copyProperties(other: object)
      }
    }
  }
}
