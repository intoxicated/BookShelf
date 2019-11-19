//
//  DataStoreService.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

enum DataSourceOperation {
  case insert
  case remove
  case find
  case upsert
}

struct DataStoreService {
  static let shared = DataStoreService()
  private let source: DataSource = RealmDataSource()
  
  private init() {}
  
  func note(
    id: String,
    text: String = "",
    type: ProductType,
    op: DataSourceOperation,
    completion: ((Note?) -> ())? = nil) {
    switch op {
    case .find:
      let item = self.source.find(type: Note.self, query: "noteId == '\(id)'").first
      completion?(item)
    case .insert:
      let item = Note(id: id, text: text, type: type.rawValue)
      self.source.insert(object: item)
      completion?(item)
    case .upsert:
      let newItem = Note(id: id, text: text, type: type.rawValue)
      if let item = self.source.find(type: Note.self, query: "noteId == '\(id)'").first {
        self.source.update(type: Note.self, id: item.noteId, object: newItem)
      } else {
        self.source.insert(object: newItem)
      }
      completion?(newItem)
    case .remove:
      self.source.remove(type: Note.self, id: id)
      completion?(nil)
    }
  }
}
