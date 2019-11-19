//
//  UIView+Extensions.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit
import RxSwift

extension UIView {
  public func frameIn(_ view: UIView?) -> CGRect {
    if let superview = superview {
     return superview.convert(frame, to: view)
    }
    return frame
  }
  
  public func caSnapshot(scale: CGFloat = 0, isOpaque: Bool = false) -> UIImage? {
    var isSuccess = false
    UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, scale)
    if let context = UIGraphicsGetCurrentContext() {
      layer.render(in: context)
      isSuccess = true
    }
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return isSuccess ? image : nil
  }
}

extension UIView {
  @objc func rxOnNext(_ gesture: UIGestureRecognizer) {
    if let rxGesture = gesture as? RxGesture {
      rxGesture.subscriber.onNext(gesture)
    }
  }

  func rxForClick(cancelTouches: Bool = true) -> Observable<Any?> {
    self.isUserInteractionEnabled = true

    return Observable.create { [weak self] subscriber in
      let gesture = RxClickGesture(
        container: self!,
        target: subscriber,
        action: #selector(self!.rxOnNext(_:))
      )
      gesture.numberOfTapsRequired = 1
      gesture.cancelsTouchesInView = cancelTouches
      self?.addGestureRecognizer(gesture)

      return Disposables.create {
        subscriber.onCompleted()
        self?.removeGestureRecognizer(gesture)
      }
    }
  }
}
