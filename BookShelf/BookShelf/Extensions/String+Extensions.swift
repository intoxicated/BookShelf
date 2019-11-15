//
//  String+Extensions.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/14/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

extension String {
  var isValidCurrency: Bool {
    //check first character as identifier such as $
    //check rest of string can be convertable to double
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
