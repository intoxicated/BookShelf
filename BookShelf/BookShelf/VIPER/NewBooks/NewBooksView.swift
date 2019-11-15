//
//  NewBooksView.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

class NewBooksView: UIViewController {
  var presenter: NewBooksPresenterProtocol?
}

extension NewBooksView: NewBooksViewProtocol {
  func display(books: [Book]) {
    
  }
  
  func displayError(_ error: Error) {
    
  }
}
