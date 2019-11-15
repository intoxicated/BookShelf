//
//  SearchTests.swift
//  SendbirdProjectTests
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Quick
import Nimble

class SearchBooksTests: QuickSpec {
  override func spec() {
    describe("") {
      context("") {
        it("") {
          
        }
      }
    }
  }
}

extension SearchBooksTests {
  class SearchBooksMockView: SearchBooksViewProtocol {
    var presenter: SearchBooksPresenterProtocol?
    
    func display(books: [Book]) {
      
    }
    
    func displayError(_ error: Error) {
      
    }
  }
  
  class SearchBooksMockRouter: SearchBooksRouterProtocol {
    static func createModule() -> UIViewController {
      return UIViewController()
    }
    
    func pushDetail(with book: Book, from view: UIViewController?) {
      
    }
  }
}
