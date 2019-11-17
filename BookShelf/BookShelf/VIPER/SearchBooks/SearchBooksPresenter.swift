//
//  SearchBooksPresenter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift
import UIKit

class SearchBooksPresenter: SearchBooksPresenterProtocol {
  var view: SearchBooksViewProtocol?
  var interactor: SearchBooksInteractorProtocol?
  var router: SearchBooksRouterProtocol?
  
  private var disposeBag = DisposeBag()
  private var isSearching = false
  
  func search(with keyword: String?) {
    guard !self.isSearching else { return }
    self.isSearching = true
    
    self.interactor?
      .search(with: keyword)
      .subscribe(onNext: { [weak self] (books, isFirst) in
        guard let self = self else { return }
        self.view?.display(books: books, isFirstRequest: isFirst)
        self.isSearching = false
      }, onError: { [weak self] (error) in
        self?.view?.displayError(error)
        self?.isSearching = false
      }).disposed(by: self.disposeBag)
  }
  
  func reset() {
    self.interactor?.reset()
  }
  
  func didClickOnBook(_ book: Book, from view: UIViewController?) {
    self.router?.pushDetail(with: book, from: view)
  }
}