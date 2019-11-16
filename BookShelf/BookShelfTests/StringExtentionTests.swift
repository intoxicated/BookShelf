//
//  StringExtentionTests.swift
//  SendbirdProjectTests
//
//  Created by R3alFr3e on 11/14/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Quick
import Nimble

class StringExtensionTests: QuickSpec {
  override func spec() {
    describe("isValidCurrency") {
      context("when a string has content that can be convertable as currency") {
        it("should return true") {
          expect("$10".isValidCurrency).to(beTrue())
          expect("R143".isValidCurrency).to(beTrue())
          expect("₩10000".isValidCurrency).to(beTrue())
        }
      }
      
      context("when a string has content that is missing identifier") {
        it("should return false") {
          let test = "10"
          expect(test.isValidCurrency).to(beFalse())
        }
      }
      
      context("when a string has content that is invalid symbol") {
        it("should return false") {
          let test = "%10"
          expect(test.isValidCurrency).to(beFalse())
        }
      }
      
      context("when a string has content that cannot be convertable to Double") {
        it("should return false") {
          let test = "$10c"
          expect(test.isValidCurrency).to(beFalse())
        }
      }
    }
    
    describe("isValidISBN13") {
      context("when a string has valid isbn13") {
        it("should return true") {
          let isbn13 = "9780306406157"
          expect(isbn13.isValidISBN13).to(beTrue())
          
          let isbn13Two = "9781617294136"
          expect(isbn13Two.isValidISBN13).to(beTrue())
        }
      }
      
      context("when a string has extra digits") {
        it("should return false") {
          let isbn13 = "97803064061564"
          expect(isbn13.isValidISBN13).notTo(beTrue())
        }
      }
      
      context("when a string has invalid character") {
        it("should return false") {
          let isbn13 = "978030640615e"
          expect(isbn13.isValidISBN13).notTo(beTrue())
        }
      }
      
      context("when a string has invalid checksum") {
        it("should return false") {
          let isbn13 = "9780306406151"
          expect(isbn13.isValidISBN13).notTo(beTrue())
        }
      }
    }
  }
}
