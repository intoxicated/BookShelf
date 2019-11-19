//
//  NoticeController.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/19/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

class NoticeController {
  static let shared = NoticeController()
  private init() {}
  
  func showAlert(
    with error: BookShelfError,
    from view: UIViewController?,
    completion: ((Bool) -> ())? = nil) {
    let alert = UIAlertController(
      title: "Error",
      message: error.localizedDescription,
      preferredStyle: .alert)

    if error.retryable {
      let retryButton = UIAlertAction(
        title: "Retry",
        style: .default,
        handler: { _ in
          completion?(true)
        })

      let cancelAction = UIAlertAction(
        title: "Cancel",
        style: .cancel,
        handler: { _ in
          completion?(false)
        })
      
      alert.addAction(retryButton)
      alert.addAction(cancelAction)
    } else {
      let okButton = UIAlertAction(
        title: "OK",
        style: .cancel,
        handler: { _ in
          completion?(false)
        })
      
      alert.addAction(okButton)
    }
    
    view?.present(alert, animated: true, completion: nil)
  }
  
  func showCompletion(
    with title: String,
    message: String,
    from view: UIViewController?) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    
    let okButton = UIAlertAction(
      title: "OK",
      style: .cancel)
    
    alert.addAction(okButton)
    view?.present(alert, animated: true, completion: nil)
  }
}
