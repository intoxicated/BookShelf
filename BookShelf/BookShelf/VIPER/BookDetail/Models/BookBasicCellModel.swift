//
//  BookBasicInfoCellModel.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

struct BookBasicCellModel {
  let titleAndYear: String
  let subtitle: String?
  let authors: String
  let rating: Double
  
  init(book: Book) {
    let title = book.title ?? "unknown"
    let year = book.year ?? "unknown"
    let authors = book.authors ?? "unknown"
    self.titleAndYear = "\(title) (\(year))"
    self.subtitle = book.subtitle
    self.authors = "by \(authors)"
    self.rating = book.rating ?? 0.0
  }
}
