//
//  BookTests.swift
//  SendbirdProjectTests
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Quick
import Nimble
import ObjectMapper

class BookTests: QuickSpec {
  override func spec() {
    describe("Book model") {
      context("when it is initialized with default constructor") {
        let book = Book()
        it("should contains all default values") {
          expect(book.authors).to(beNil())
          expect(book.title).to(beNil())
          expect(book.price).to(beNil())
          expect(book.type).to(equal(.book))
        }
      }
      
      context("when it is initialized with parameter constructor") {
        let book = Book(
          authors: "Shakespear", desc: nil, error: nil,
          image: nil, isbn10: nil, isbn13: nil, pages: nil,
          pdf: nil, price: "$100.10", publisher: nil,
          rating: nil, subtitle: nil, title: "Hamlet",
          type: .book, url: nil, year: nil)
        
        it("should contains all provided values") {
          expect(book.authors).to(equal("Shakespear"))
          expect(book.title).to(equal("Hamlet"))
          expect(book.price).to(equal("$100.10"))
          expect(book.type).to(equal(.book))
        }
      }
      
      context("when it is deserialized from json string") {
        let jsonString = """
        {
            "title": "Designing Across Senses",
            "subtitle": "A Multimodal Approach to Product Design",
            "isbn13": "9781491954249",
            "price": "$27.59",
            "image": "https://itbook.store/img/books/9781491954249.png",
            "url": "https://itbook.store/books/9781491954249"
        }
        """
        
        let book = Mapper<Book>().map(JSONString: jsonString)
        it("should contains all provided values") {
          expect(book).notTo(beNil())
          expect(book?.authors).to(beNil())
          expect(book?.title).to(equal("Designing Across Senses"))
          expect(book?.price).to(equal("$27.59"))
          expect(book?.isbn13).to(equal("9781491954249"))
          expect(book?.image).to(equal("https://itbook.store/img/books/9781491954249.png"))
          expect(book?.url).to(equal("https://itbook.store/books/9781491954249"))
        }
      }
    }
  }
}

