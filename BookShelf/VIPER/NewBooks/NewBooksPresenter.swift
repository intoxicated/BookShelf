//
//  NewBooksPresenter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit
import RxSwift
import RxSwiftExt

class NewBooksPresenter: NewBooksPresenterProtocol {
  weak var view: NewBooksViewProtocol?
  var interactor: NewBooksInteractorProtocol?
  var router: NewBooksRouterProtocol?
  
  var disposeBag = DisposeBag()
  
  func fetch() {
    self.interactor?
      .fetch()
      .retry(.delayed(maxCount: 3, time: 3.0))
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] (books) in
        self?.view?.display(books: books)
      }, onError: { [weak self] _ in
        self?.view?.displayError(.networkError)
      }).disposed(by: self.disposeBag)
  }
  
  func didClickOnBook(_ book: Book, from view: UIViewController?) {
    self.router?.pushDetail(with: book, from: view)
  }
  
  func didClickOnLink(_ url: URL, from view: UIViewController?) {
    self.router?.presentLink(with: url, from: view, completion: { (completed) in
      if !completed {
        self.view?.displayError(.linkError)
      }
    })
  }
}
