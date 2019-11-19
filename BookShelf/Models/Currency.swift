//
//  Currency.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import ObjectMapper
import SwiftyJSON

struct Currency {
  var code: String = ""
  var decimalDigits: Int = 0
  var name: String = ""
  var namePlural: String = ""
  var rounding: Int = 0
  var symbol: String = ""
  var symbolNative: String = ""
}

extension Currency: Mappable {
  init?(map: Map) { }
  
  mutating func mapping(map: Map) {
    code          <- map["symbol"]
    decimalDigits <- map["decimal_digits"]
    name          <- map["name"]
    namePlural    <- map["name_plural"]
    rounding      <- map["rouding"]
    symbol        <- map["symbol"]
    symbolNative  <- map["symbol_native"]
  }
  
  static func getAll() -> [Currency] {
    do {
      let path = Bundle.main.path(forResource: "currency", ofType: "json") ?? ""
      let data = try Data(contentsOf: URL(fileURLWithPath: path))
      let json = try SwiftyJSON.JSON(data: data)
      
      let currencies = json.dictionaryObject?.values.compactMap {
        Mapper<Currency>().map(JSONObject: $0)
      }
      
      return currencies ?? []
    } catch {
      return []
    }
  }
}
