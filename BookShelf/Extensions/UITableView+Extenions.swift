//
//  UITableView+Extenions.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/18/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

enum IndicatorPosition {
  case header, footer, center
}

extension UITableView {
  static let indicatorTagNumber = 1004
  
  func showEmpty(with message: String) {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    let label = UILabel().then {
      $0.text = message
      $0.font = UIFont.systemFont(ofSize: 17)
      $0.textColor = .gray
      $0.textAlignment = .center
    }
    view.addSubview(label)
    label.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.leading.equalToSuperview().inset(20)
      make.trailing.equalToSuperview().inset(20)
    }
    
    self.backgroundView = view
  }
  
  func showIndicatorTo(_ position: IndicatorPosition) {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))

    let indicator = UIActivityIndicatorView()
    indicator.tag = UITableView.indicatorTagNumber
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    
    view.addSubview(indicator)
    indicator.snp.makeConstraints { make in
      make.width.equalTo(40)
      make.height.equalTo(40)
      make.center.equalToSuperview()
    }

    switch position {
    case .header: self.tableHeaderView = view
    case .footer: self.tableFooterView = view
    case .center: self.backgroundView = view
    }
  }

  func hideIndicatorTo(_ position: IndicatorPosition) {
    switch position {
    case .header: self.tableHeaderView = nil
    case .footer: self.tableFooterView = nil
    case .center: self.backgroundView = nil
    }
  }
  
  func hideIndicator() {
    self.tableHeaderView = nil
    self.tableFooterView = nil
    self.backgroundView = nil
  }
  
  var activityPosition: IndicatorPosition? {
    if let view = self.tableHeaderView, view.tag == UITableView.indicatorTagNumber {
      return .header
    } else if let view = self.backgroundView, view.tag == UITableView.indicatorTagNumber {
      return .center
    } else if let view = self.tableFooterView, view.tag == UITableView.indicatorTagNumber {
      return .footer
    }
    return nil
  }
}
