//
//  CustomTransforms.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import ObjectMapper

class OMStringToIntTransform: TransformType {
  typealias Object = Int
  typealias JSON = String

  init() {}
  func transformFromJSON(_ value: Any?) -> Int? {
    if let strValue = value as? String {
      return Int(strValue)
    }
    return value as? Int
  }

  func transformToJSON(_ value: Int?) -> String? {
    if let intValue = value {
      return "\(intValue)"
    }
    return nil
  }
}

class OMStringToDoubleTransform: TransformType {
  typealias Object = Double
  typealias JSON = String

  init() {}
  func transformFromJSON(_ value: Any?) -> Double? {
    if let strValue = value as? String {
      return Double(strValue)
    }
    return value as? Double
  }

  func transformToJSON(_ value: Double?) -> String? {
    if let doubleValue = value {
      return "\(doubleValue)"
    }
    return nil
  }
}

class OMStringToUrlTransform: TransformType {
  typealias Object = URL
  typealias JSON = String
  
  init() {}
  func transformFromJSON(_ value: Any?) -> URL? {
    if let strValue = value as? String {
      return URL(string: strValue)
    }
    return value as? URL
  }

  func transformToJSON(_ value: URL?) -> String? {
    if let value = value {
      return value.absoluteString
    }
    return nil
  }
}

class OMStringDictToUrlTransform: TransformType {
  typealias Object = [String: URL?]
  typealias JSON = [String: String]
  
  init() {}
  func transformFromJSON(_ value: Any?) -> [String: URL?]? {
    if let dict = value as? [String: String] {
      return dict.mapValues { URL(string: $0) }
    }
    return value as? [String: URL?]
  }
  
  func transformToJSON(_ value: [String : URL?]?) -> [String : String]? {
    if let value = value {
      return value.compactMapValues { $0?.absoluteString }
    }
    return nil
  }
}
