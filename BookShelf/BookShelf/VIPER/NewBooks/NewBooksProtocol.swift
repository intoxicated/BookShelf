//
//  NewBooksProtocol.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift

protocol NewBooksViewProtocol: class {
  var presenter: NewBooksPresenterProtocol? { get set }
  
  func display(books: [Book])
  func displayError(_ error: Error)
}

protocol NewBooksPresenterProtocol: class {
  var view: NewBooksViewProtocol? { get set }
  var interactor: NewBooksInteractorProtocol? { get set }
  var router: NewBooksRouterProtocol? { get set }
  
  func fetch()
  func didClickOnBook(_ book: Book, from view: UIViewController?)
}

protocol NewBooksInteractorProtocol: class {
  var presenter: NewBooksPresenterProtocol? { get set }
  
  func fetch() -> Observable<[Book]>
}

protocol NewBooksRouterProtocol: class {
  static func createModule() -> NewBooksView
  
  func pushDetail(with book: Book, from view: UIViewController?)
}
