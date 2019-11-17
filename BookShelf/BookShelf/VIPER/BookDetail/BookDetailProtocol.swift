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
  func saveCompleted(success: Bool)
}

protocol BookDetailPresenterProtocol: class {
  var view: BookDetailViewProtocol? { get set }
  var interactor: BookDetailInteractorProtocol? { get set }
  var router: BookDetailRouterProtocol? { get set }
  
  func fetch()
  func didClickOnSaveForNote(text: String?, from view: UIViewController?)
  func didClickOnLink(_ url: URL, from view: UIViewController?)
}

protocol BookDetailInteractorProtocol: class {
  var presenter: BookDetailPresenterProtocol? { get set }
  var book: Book? { get set }
  
  func fetch() -> Observable<Book?>
  func saveNote(text: String?) -> Observable<Bool>
}

protocol BookDetailRouterProtocol: class {
  static func createModule(with book: Book) -> BookDetailView
  
  func presentLink(with url: URL, from view: UIViewController?, completion: ((Bool) -> ())?)
}
