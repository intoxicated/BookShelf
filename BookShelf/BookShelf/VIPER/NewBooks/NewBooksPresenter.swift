//
//  NewBooksPresenter.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

class NewBooksPresenter: NewBooksPresenterProtocol {
  weak var view: NewBooksViewProtocol?
  var interactor: NewBooksInteractorProtocol?
  var router: NewBooksRouterProtocol?
  
  func fetch() {
    
  }
  
  func didClickOnBook(_ book: Book, from view: UIViewController?) {
    
  }
}
