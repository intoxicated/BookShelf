//
//  BookDetailInteractor.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift

class BookDetailInteractor: BookDetailInteractorProtocol {
  var presenter: BookDetailPresenterProtocol?
  var book: Book?
  
  func fetch() -> Observable<Book?> {
    guard let book = self.book else {
      return .error(BSError.prepError)
    }
    
    return book.getDetail()
  }
  
  func saveNote(text: String?) -> Observable<Bool> {
    return Observable.create { [weak self] (subscriber) in
      let signal = self?.book?.takeNote(text: text ?? "")
        .subscribe(onNext: { (note) in
          subscriber.onNext(note != nil)
          subscriber.onCompleted()
        })
      return Disposables.create {
        signal?.dispose()
      }
    }
  }
}
