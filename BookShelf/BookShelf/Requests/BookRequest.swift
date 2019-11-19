//
//  BookRequests.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/19/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Alamofire
import ObjectMapper
import RxSwift
import SwiftyJSON

protocol BookRequestProtocol {
  func getDetail(from isbn13: String?) -> Observable<Book?>
  func getNews() -> Observable<[Book]>
  func search(with keyword: String, page: Int) -> Observable<([Book], Int)>
}

struct BookRequest: BookRequestProtocol {
  static let shared = BookRequest()
  private init() {}
  
  func getDetail(from isbn13: String?) -> Observable<Book?> {
    guard let isbn13 = isbn13 else {
      return .just(nil)
    }
    return Observable.create { (subscriber) -> Disposable in
      let req = Alamofire
        .request(RestService.GetBookDetail(isbn13))
        .validate(statusCode: 200..<300)
        .responseWith { response in
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
  
  func getNews() -> Observable<[Book]> {
    return Observable.create { (subscriber) -> Disposable in
      let req = Alamofire
        .request(RestService.GetNewBooks)
        .validate(statusCode: 200..<300)
        .responseWith { response in
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
  
  func search(with keyword: String, page: Int) -> Observable<([Book], Int)> {
    return Observable.create { (subscriber) -> Disposable in
      let req = Alamofire
        .request(RestService.SearchBook(keyword, page))
        .validate(statusCode: 200..<300)
        .responseWith { response in
          switch response.result {
          case .success(let data):
            let json = SwiftyJSON.JSON(data)
            let total = json["total"].intValue
            let books = Mapper<Book>().mapArray(JSONObject: json["books"].object) ?? []
            subscriber.onNext((books, total))
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
  
  
}
