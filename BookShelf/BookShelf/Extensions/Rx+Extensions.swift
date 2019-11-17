//
//  Rx+Extensions.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift

protocol RxGesture {
  var subscriber: AnyObserver<Any?> { get set }
}

class RxClickGesture: UITapGestureRecognizer, RxGesture {
  var subscriber: AnyObserver<Any?>

  init(container: UIView, target: AnyObserver<Any?>, action: Selector?) {
    self.subscriber = target
    super.init(target: container, action: action)
  }
}
