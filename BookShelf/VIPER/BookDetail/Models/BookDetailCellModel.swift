//
//  BookDetailCellModel.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

struct BookDetailCellModel {
  let price: String
  let publisher: String
  let pages: String
  let isbns: String
  let desc: String?
  
  init(book: Book) {
    let priceValue = book.price?.isValidCurrency == true ?
      book.price! : "unknown"
    self.price = "Price: \(priceValue)"
    self.publisher = "Publisher: \(book.publisher ?? "unknown")"
    
    if let pages = book.pages {
      self.pages = "Pages: \(pages)"
    } else {
      self.pages = "Pages: unknown"
    }
    
    var isbns = ""
    let isbn10 = book.isbn10 ?? "unknown"
    let isbn13 = book.isbn13 ?? "unknown"
    isbns = "ISBN10: \(isbn10)"
    isbns += "\n"
    isbns += "ISBN13: \(isbn13)"
    
    self.isbns = isbns
    self.desc = book.desc
  }
}
