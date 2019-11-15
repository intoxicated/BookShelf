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
  
  func display(books: [Book])
  //func add(books: [Book])
  func displayError(_ error: Error)
}

protocol SearchBooksPresenterProtocol: class {
  var view: SearchBooksViewProtocol? { get set }
  var interactor: SearchBooksInteractorProtocol? { get set }
  var router: SearchBooksRouterProtocol? { get set }
  
  func search(with keyword: String)
  func didClickResult(book: Book, from view: UIViewController?)
}

protocol SearchBooksInteractorProtocol: class {
  var presenter: SearchBooksPresenterProtocol? { get set }
  
  func search(with keyword: String, nextPage: Int) -> Observable<[Book]>
}

protocol SearchBooksRouterProtocol: class {
  static func createModule() -> UIViewController
  
  func pushDetail(with book: Book, from view: UIViewController?)
}
