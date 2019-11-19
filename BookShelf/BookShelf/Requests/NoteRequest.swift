//
//  NoteRequest.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/19/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift

protocol NoteRequestProtocol {
  func get(type: ProductType, id: String) -> Observable<String?>
  func set(type: ProductType, id: String, text: String) -> Observable<Note?>
}

struct NoteRequest: NoteRequestProtocol {
  static let shared = NoteRequest()
  private init() {}
  
  func get(type: ProductType, id: String) -> Observable<String?> {
    return Observable.create { (subscriber) in
      DataStoreService.shared.note(
        id: id,
        type: type,
        op: .find) { (note) in
          subscriber.onNext(note?.text)
          subscriber.onCompleted()
        }
      
      return Disposables.create()
    }
  }
  
  func set(type: ProductType, id: String, text: String) -> Observable<Note?> {
    return Observable.create { (subscriber) in
      DataStoreService.shared.note(
        id: id,
        text: text,
        type: type,
        op: .upsert) { (note) in
          subscriber.onNext(note)
          subscriber.onCompleted()
        }
      
      return Disposables.create()
    }
  }
}
