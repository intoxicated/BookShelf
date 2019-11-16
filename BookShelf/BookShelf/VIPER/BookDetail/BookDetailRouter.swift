//
//  BookDetailRouter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import SafariServices

class BookDetailRouter: BookDetailRouterProtocol {
  static func createModule(with book: Book) -> BookDetailView {
    let view = BookDetailView()
    let presenter = BookDetailPresenter()
    let interactor = BookDetailInteractor()
    let router = BookDetailRouter()

    view.book = book
    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    interactor.book = book
    
    return view
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
