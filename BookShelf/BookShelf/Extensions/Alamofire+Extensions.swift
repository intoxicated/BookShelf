//
//  Alamofire+Extensions.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/18/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Alamofire

extension DataRequest {
  @discardableResult
  public func responseWith(
    queue: DispatchQueue? = nil,
    options: JSONSerialization.ReadingOptions = .allowFragments,
    completionHandler: @escaping (DataResponse<Data>) -> Void) -> Self {
    return response(
      queue: queue == nil ? RestService.queue : queue,
      responseSerializer: DataRequest.dataResponseSerializer(options: options),
      completionHandler: completionHandler
    )
  }

  public static func dataResponseSerializer(
    options: JSONSerialization.ReadingOptions = .allowFragments) -> DataResponseSerializer<Data> {
    return DataResponseSerializer { request, response, data, error in
      let result = Request.serializeResponseData(response: response, data: data, error: error)

      //cache if possible
      if let data = data,
        let response = response,
        let request = request {
        let cachedURLResponse = CachedURLResponse(
          response: response,
          data: data,
          userInfo: nil,
          storagePolicy: .allowed
        )
        URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
      }
      
      switch result {
      case .success(let value):
        return .success(value)
      case .failure(let error):
        return .failure(error)
      }
    }
  }
}
