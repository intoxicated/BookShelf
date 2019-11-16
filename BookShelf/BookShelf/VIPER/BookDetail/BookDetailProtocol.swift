//
//  BookDetailProtocols.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//
import RxSwift

protocol BookDetailViewProtocol: class {
  var presenter: BookDetailPresenterProtocol? { get set }
  
  func display(book: Book)
  func displayError(_ error: Error)
}

protocol BookDetailPresenterProtocol: class {
  var view: BookDetailViewProtocol? { get set }
  var interactor: BookDetailInteractorProtocol? { get set }
  var router: BookDetailRouterProtocol? { get set }
  
  func fetch()
  func didClickOnLink(_ url: URL, from view: UIViewController?)
}

protocol BookDetailInteractorProtocol: class {
  var presenter: BookDetailPresenterProtocol? { get set }
  var book: Book? { get set }
  
  func fetch() -> Observable<Book?>
}

protocol BookDetailRouterProtocol: class {
  static func createModule(with book: Book) -> BookDetailView
  
  func presentLink(with url: URL, from view: UIViewController?, completion: ((Bool) -> ())?)
}
