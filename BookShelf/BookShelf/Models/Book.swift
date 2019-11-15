//
//  Book.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import ObjectMapper

struct Book: Product {
  var authors: String?
  var desc: String?
  var error: String?
  var image: String?
  var isbn10: String?
  var isbn13: String?
  var pages: Int?
  var pdf: [String: String]?
  var price: String?
  var publisher: String?
  var rating: String?
  var subtitle: String?
  var title: String?
  var type: ProductType = .book
  var url: String?
  var year: String?
}

extension Book: Mappable {
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    authors      <- map["authors"]
    desc         <- map["desc"]
    error        <- map["error"]
    image        <- map["image"]
    isbn10       <- map["isbn10"]
    isbn13       <- map["isbn13"]
    pages        <- map["pages"]
    pdf          <- map["pdf"]
    price        <- map["price"]
    publisher    <- map["publisher"]
    rating       <- map["rating"]
    subtitle     <- map["subtitle"]
    title        <- map["title"]
    type         <- map["type"]
    url          <- map["url"]
    year         <- map["year"]
  }
}

extension Book: Equatable {
  static func == (lhs:Book, rhs:Book) -> Bool {
    return lhs.authors == rhs.authors &&
      lhs.desc == rhs.desc &&
      lhs.error == rhs.error &&
      lhs.image == rhs.image &&
      lhs.isbn10 == rhs.isbn10 &&
      lhs.isbn13 == rhs.isbn13 &&
      lhs.pages == rhs.pages &&
      lhs.pdf == rhs.pdf &&
      lhs.price == rhs.price &&
      lhs.publisher == rhs.publisher &&
      lhs.rating == rhs.rating &&
      lhs.subtitle == rhs.subtitle &&
      lhs.title == rhs.title &&
      lhs.type == rhs.type &&
      lhs.url == rhs.url &&
      lhs.year == rhs.year
  }
}
