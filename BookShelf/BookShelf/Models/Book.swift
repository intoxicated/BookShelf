//
//  Book.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import ObjectMapper
import RxSwift
import Alamofire
import SwiftyJSON

struct Book: Product {
  var authors: String? //basic
  var desc: String? //detail
  var error: String?
  var image: URL?
  var isbn10: String? //detail
  var isbn13: String? //detail
  var pages: Int? //detail
  var pdf: [String: URL?]? //misc
  var price: String? //detail
  var publisher: String? //detail
  var rating: Double? //basic
  var subtitle: String? //basic
  var title: String? //basic
  var type: ProductType = .book
  var url: URL? //misc
  var year: String? //basic
}

extension Book: Mappable {
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    authors      <- map["authors"]
    desc         <- map["desc"]
    error        <- map["error"]
    image        <- (map["image"], OMStringToUrlTransform())
    isbn10       <- map["isbn10"]
    isbn13       <- map["isbn13"]
    pages        <- (map["pages"], OMStringToIntTransform())
    pdf          <- (map["pdf"], OMStringDictToUrlTransform())
    price        <- map["price"]
    publisher    <- map["publisher"]
    rating       <- (map["rating"], OMStringToDoubleTransform())
    subtitle     <- map["subtitle"]
    title        <- map["title"]
    type         <- map["type"]
    url          <- (map["url"], OMStringToUrlTransform())
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

extension Book {
  func getDetail() -> Observable<Book?> {
    guard let isbn13 = self.isbn13 else {
      return .just(nil)
    }
    return Observable.create { (subscriber) -> Disposable in
      let req = Alamofire
        .request(RestService.GetBookDetail(isbn13))
        .validate(statusCode: 200..<300)
        .responseJSON { response in
          switch response.result {
          case .success(let data):
            let json = SwiftyJSON.JSON(data)
            let book = Mapper<Book>().map(JSONObject: json.object)
            subscriber.onNext(book)
            subscriber.onCompleted()
          case .failure(let error):
            subscriber.onError(error)
          }
        }
      return Disposables.create {
        req.cancel()
      }
    }
  }
  
  static func getNews() -> Observable<[Book]> {
    return Observable.create { (subscriber) -> Disposable in
      let req = Alamofire.request(RestService.GetNewBooks)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
          switch response.result {
          case .success(let data):
            let json = SwiftyJSON.JSON(data)
            let books = Mapper<Book>().mapArray(JSONObject: json["books"].object) ?? []
            subscriber.onNext(books)
            subscriber.onCompleted()
          case .failure(let error):
            subscriber.onError(error)
          }
        }
      
      return Disposables.create {
        req.cancel()
      }
    }
  }
  
  static func search(with keyword: String, page: Int) -> Observable<[Book]> {
    return .just([])
  }
}
