//
//  BookDetailPresenter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift
import RxSwiftExt

class BookDetailPresenter: BookDetailPresenterProtocol {
  weak var view: BookDetailViewProtocol?
  var interactor: BookDetailInteractorProtocol?
  var router: BookDetailRouterProtocol?
  
  private var disposeBag = DisposeBag()
  
  func fetch() {
    self.interactor?
      .fetch()
      .retry(.delayed(maxCount: 3, time: 3.0))
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] (book) in
        if let book = book {
          self?.view?.display(book: book)
        } else {
          self?.view?.displayError(.parseError)
        }
      }, onError: { [weak self] _ in
        self?.view?.displayError(.networkError)
      }).disposed(by: self.disposeBag)
  }
  
  func didClickOnLink(_ url: URL, from view: UIViewController?) {
    self.router?.presentLink(with: url, from: view, completion: { (completion) in
      if !completion {
        self.view?.displayError(.linkError)
      }
    })
  }
  
  func didClickOnSaveForNote(text: String?, from view: UIViewController?) {
    self.interactor?
      .saveNote(text: text)
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] (completed) in
        self?.view?.saveCompleted(success: completed)
      }).disposed(by: self.disposeBag)
  }
}
