//
//  Note.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RealmSwift
import RxSwift

protocol Notable {
  var id: String { get }
  var type: ProductType { get }
  
  func getNote() -> Observable<String?>
  func takeNote(text: String) -> Observable<Note?>
}

@objcMembers class Note: BaseObject {
  dynamic var noteId = ""
  dynamic var text = ""
  dynamic var lastUpdated = Date()
  dynamic var type = ""

  override class func primaryKey() -> String? {
    return "noteId"
  }
  
  init(id: String, text: String, type: String) {
    self.noteId = id
    self.text = text
    self.type = type
  }
  
  required init() {
    self.noteId = ""
    self.text = ""
    self.type = ""
    self.lastUpdated = Date()
  }
 
  override func copyProperties(other: Any?) {
    guard let other = other as? Note else { return }
    self.text = other.text
    self.type = other.type
    self.lastUpdated = other.lastUpdated
  }
}

