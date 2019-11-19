//
//  SearchBooksRouter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import SafariServices
import UIKit

class SearchBooksRouter: SearchBooksRouterProtocol {
  static func createModule() -> SearchBooksView {
    let view = SearchBooksView()
    let presenter = SearchBooksPresenter()
    let interactor = SearchBooksInteractor()
    let router = SearchBooksRouter()
    
    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    return view
  }
  
  func pushDetail(with book: Book, from view: UIViewController?) {
    let detail = BookDetailRouter.createModule(with: book)
    view?.navigationController?.pushViewController(detail, animated: true)
  }
  
  func presentLink(
    with url: URL,
    from view: UIViewController?,
    completion: ((Bool) -> ())? = nil) {
    guard UIApplication.shared.canOpenURL(url) else {
      completion?(false)
      return
    }
    
    let controller = SFSafariViewController(url: url)
    controller.modalPresentationStyle = .automatic
    view?.present(controller, animated: true, completion: {
      completion?(true)
    })
  }
}
