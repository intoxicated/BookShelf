//
//  String+Extensions.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/14/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//
import UIKit

extension String {
  var isValidCurrency: Bool {
    let index = self.firstIndex { (char) -> Bool in
      return char.unicodeScalars.contains(where: {
        CharacterSet.decimalDigits.contains($0)
      })
    }
    
    if let index = index {
      let symbol = String(self[..<index])
      let value = String(self[index...])
      guard Double(value) != nil else {
        return false
      }
      
      let currencySet = Currency.getAll()
      for currency in currencySet {
        if currency.symbolNative == symbol {
          return true
        }
      }
      return false
    }
    return false
  }
  
  var isValidISBN13: Bool {
    //https://en.wikipedia.org/wiki/International_Standard_Book_Number#ISBN-13_check_digit_calculation
    var numbers = self.compactMap { Int(String($0)) }
    //contains invalid character
    if numbers.count != 13 {
      return false
    }
    
    guard let lastDigit = numbers.popLast() else {
      return false
    }
    
    var sum = 0
    for (index, value) in numbers.enumerated() {
      sum += index & 1 == 1 ? 3 * value : value
    }
    
    let checkSum = 10 - (sum % 10)
    return checkSum == lastDigit
  }
}
