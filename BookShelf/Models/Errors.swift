//
//  Errors.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Foundation

enum BookShelfError: Error {
  case linkError
  case parseError
  case prepError
  case networkError
}

extension BookShelfError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .linkError:
      return "The link is invalid"
    case .parseError:
      return "Error while reading data from network. Would you want to try again?"
    case .prepError:
      return "Internal error. Book entity did not set properly"
    case .networkError:
      return "Network error. Would you want to try again?"
    }
  }
  
  var retryable: Bool {
    switch self {
    case .parseError, .networkError:
      return true
    default:
      return false
    }
  }
}

