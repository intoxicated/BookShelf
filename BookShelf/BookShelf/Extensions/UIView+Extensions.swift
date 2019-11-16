//
//  UIView+Extensions.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

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
