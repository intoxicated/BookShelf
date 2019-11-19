//
//  SearchBooksProtocol.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift

protocol SearchBooksViewProtocol: class {
  var presenter: SearchBooksPresenterProtocol? { get set }
  
  func display(books: [Book], isFirstRequest: Bool)
  func displayError(_ error: BookShelfError)
}

protocol SearchBooksPresenterProtocol: class {
  var view: SearchBooksViewProtocol? { get set }
  var interactor: SearchBooksInteractorProtocol? { get set }
  var router: SearchBooksRouterProtocol? { get set }
  
  func reset()
  func search(with keyword: String?)
  func didClickOnBook(_ book: Book, from view: UIViewController?)
  func didClickOnLink(_ url: URL, from view: UIViewController?)
}

protocol SearchBooksInteractorProtocol: class {
  func reset()
  func search(with keyword: String?) -> Observable<([Book], Bool)>
}

protocol SearchBooksRouterProtocol: class {
  static func createModule() -> SearchBooksView
  
  func pushDetail(with book: Book, from view: UIViewController?)
  func presentLink(with url: URL, from view: UIViewController?, completion: ((Bool) -> ())?)
}
