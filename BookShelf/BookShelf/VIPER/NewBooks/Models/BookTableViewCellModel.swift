//
//  NewBooksCellModel.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

struct BookTableViewCellModel {
  let title: String?
  let subtitle: String?
  let imageUrl: URL?
  let price: String?
  let isbn13: String?
  let url: String?
  
  init(book: Book) {
    self.title = book.title
    self.subtitle = book.subtitle
    self.imageUrl = book.image
    self.price = book.price
    self.isbn13 = book.isbn13
    self.url = book.url?.absoluteString
  }
}
