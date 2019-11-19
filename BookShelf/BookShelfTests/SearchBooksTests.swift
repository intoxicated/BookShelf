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
    
    func display(books: [Book], isFirstRequest: Bool) {
      
    }
    
    func displayError(_ error: Error) {
      
    }
  }
  
  class SearchBooksMockRouter: SearchBooksRouterProtocol {
    static func createModule() -> SearchBooksView {
      return SearchBooksView()
    }
    
    func pushDetail(with book: Book, from view: UIViewController?) {
      
    }
    
    func presentLink(with url: URL, from view: UIViewController?, completion: ((Bool) -> ())?) {
      
    }
  }
}
