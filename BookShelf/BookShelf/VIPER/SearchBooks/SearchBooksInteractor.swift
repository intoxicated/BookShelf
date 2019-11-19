//
//  SearchBooksInteractor.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift

class SearchBooksInteractor: SearchBooksInteractorProtocol {
  private var keyword: String? = ""
  private var nextPage = 1
  private var books: [Book] = []
  private var total: Int?
  
  private var hasMoreData: Bool {
    if let total = self.total, self.books.count == total {
      return false
    }
    return true
  }
  
  func search(with keyword: String?) -> Observable<([Book], Bool)> {
    return Observable.create { [weak self] (subscriber) in
      guard let self = self else {
        return Disposables.create()
      }
      
      self.prep(with: keyword)
      
      if !self.hasMoreData {
        subscriber.onNext(([], false))
        subscriber.onCompleted()
        return Disposables.create()
      }
      
      if let keyword = keyword, keyword.isEmpty {
        self.reset()
        subscriber.onNext(([], false))
        subscriber.onCompleted()
        return Disposables.create()
      }
      
      let signal = Book
        .search(with: keyword ?? "", page: self.nextPage)
        .subscribe(onNext: { (books, total) in
          self.total = total
          self.books = self.books + books
          subscriber.onNext((self.books, self.nextPage == 1))
          subscriber.onCompleted()
        }, onError: { (error) in
          subscriber.onError(error)
        })
      return Disposables.create {
        signal.dispose()
      }
    }
  }
  
  func reset() {
    self.books = []
    self.nextPage = 1
    self.keyword = ""
  }
  
  private func prep(with keyword: String?) {
    if self.keyword != keyword {
      self.keyword = keyword
      self.books = []
      self.nextPage = 1
      self.total = nil
    } else {
      self.nextPage += 1
    }
  }
}
