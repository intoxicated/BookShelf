//
//  BookMiscCellModel.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

struct BookMiscCellModel {
  let url: String?
  let pdfs: String?

  init(book: Book) {
    self.url = book.url?.absoluteString
    self.pdfs = book.pdf?.reduce("", { (result, data) -> String in
      return result + "\(data.key) : \(data.value?.absoluteString ?? "")\n"
    })
  }
}
