//
//  NewBooksRouter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import SafariServices
import UIKit

class NewBooksRouter: NewBooksRouterProtocol {
  static func createModule() -> NewBooksView {
    let view = NewBooksView()
    let presenter = NewBooksPresenter()
    let interactor = NewBooksInteractor()
    let router = NewBooksRouter()
    
    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    return view
  }
  
  func pushDetail(with book: Book, from view: UIViewController?) {
    //push book detail
  }
  
  func pushLink(with url: URL, from view: UIViewController?, completion: ((Bool) -> ())? = nil) {
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
