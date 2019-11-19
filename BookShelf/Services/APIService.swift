//
//  APIService.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/15/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Alamofire

typealias ParametersType = Parameters

enum RestService: URLRequestConvertible {
  case SearchBook(String, Int)
  case GetNewBooks
  case GetBookDetail(String)
  
  static let queue = DispatchQueue(
    label: "com.sendbird.project",
    qos: .background,
    attributes: .concurrent
  )
  
  var baseURL: String {
    return "https://api.itbook.store/1.0/"
  }
  
  var method: HTTPMethod {
    switch self {
    case .SearchBook,
         .GetNewBooks,
         .GetBookDetail:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .SearchBook(let query, let page):
      return "search/\(query)/\(page)"
    case .GetNewBooks:
      return "new"
    case .GetBookDetail(let isbn13):
      return "books/\(isbn13)"
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try self.baseURL.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    urlRequest.timeoutInterval = 5
    urlRequest.cachePolicy = .returnCacheDataElseLoad
    return urlRequest
  }
}
