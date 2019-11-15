//
//  NewBooksInteractor.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift

class NewBooksInteractor: NewBooksInteractorProtocol {
  var presenter: NewBooksPresenterProtocol?
  
  func fetch() -> Observable<[Book]> {
    return Book.getNews()
  }
}
