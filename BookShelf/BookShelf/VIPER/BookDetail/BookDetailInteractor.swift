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
}
