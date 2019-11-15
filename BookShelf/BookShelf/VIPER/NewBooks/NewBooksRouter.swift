//
//  NewBooksRouter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

class NewBooksRouter: NewBooksRouterProtocol {
  static func createModule() -> NewBooksView {
    let view = NewBooksView()
    
    return view
  }
  
  func pushDetail(with book: Book, from view: UIViewController?) {
    
  }
}
