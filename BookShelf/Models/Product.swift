//
//  Product.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Foundation

enum ProductType: String {
  case book
}

//in case other product can add in near future, it can implement this protocol
protocol Product {
  var title: String? { get set }
  var price: String? { get set }
  var type: ProductType { get set }
}
