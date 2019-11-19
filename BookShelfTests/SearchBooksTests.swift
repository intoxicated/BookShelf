//
//  SearchTests.swift
//  SendbirdProjectTests
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Quick
import Nimble
import RxSwift

class SearchBooksTests: QuickSpec {
  var view: SearchBooksMockView?
  var presenter = SearchBooksPresenter()
  var interactor = SearchBooksInteractor()
  var router: SearchBooksMockRouter?
  var disposeBag = DisposeBag()
  
  let maxTimeOut: TimeInterval = 4.0
  
  override func spec() {
    describe("") {
      beforeEach {
        self.view = SearchBooksMockView()
        self.router = SearchBooksMockRouter()
        self.disposeBag = DisposeBag()
        
        self.presenter.view = self.view
        self.presenter.interactor = self.interactor
        self.presenter.router = self.router
        self.view?.presenter = self.presenter
      }
      
      context("when search was called") {
        it("should fetch and return values to view") {
          self.presenter.search(with: "mongodb")
          expect(self.view?.didFetchCalled)
            .toEventually(
              equal(true),
              timeout: self.maxTimeOut,
              pollInterval: 1.0
            )
        }
      }
      
      context("when push detail was called") {
        it("should hand over to its router") {
          let book = Book()
          self.presenter.didClickOnBook(book, from: nil)
          expect(self.router?.pushDetailCalled).to(beTrue())
        }
      }
      
      context("when valid url link was clicked") {
        it("should hand over to its router") {
          let url = URL(string: "https://google.com")!
          self.presenter.didClickOnLink(url, from: nil)
          expect(self.router?.pushLinkCalled).to(beTrue())
        }
      }
      
      context("when invalid link was clicked") {
        it("should signal view about the result") {
          let url = URL(string: "testlink")!
          self.presenter.didClickOnLink(url, from: nil)
          expect(self.router?.pushLinkCalled).to(beTrue())
          expect(self.view?.didErrorCalled).to(beTrue())
        }
      }
    }

    describe("Interactor") {
      context("fetch new books") {
        it("should return some values") {
          waitUntil(timeout: self.maxTimeOut) { done in
            self.interactor
              .search(with: "mongodb")
              .subscribe(onNext: { (books, total) in
                expect(books.count).notTo(equal(0))
                done()
              }, onError: { (error) in
                done()
              }).disposed(by: self.disposeBag)
          }
        }
      }
    }
  }
}

extension SearchBooksTests {
  class SearchBooksMockView: SearchBooksViewProtocol {
    var presenter: SearchBooksPresenterProtocol?
    var didFetchCalled = false
    var didErrorCalled = false
    
    func display(books: [Book], isFirstRequest: Bool) {
      self.didFetchCalled = true
    }
    
    func displayError(_ error: BookShelfError) {
      self.didErrorCalled = true
    }
  }
  
  class SearchBooksMockRouter: SearchBooksRouterProtocol {
    var pushDetailCalled = false
    var pushLinkCalled = false
    
    static func createModule() -> SearchBooksView {
      return SearchBooksView()
    }
    
    func pushDetail(with book: Book, from view: UIViewController?) {
      self.pushDetailCalled = true
    }
    
    func presentLink(with url: URL, from view: UIViewController?, completion: ((Bool) -> ())?) {
      self.pushLinkCalled = true
      guard UIApplication.shared.canOpenURL(url) else {
        completion?(false)
        return
      }
      
      completion?(true)
    }
  }
}
