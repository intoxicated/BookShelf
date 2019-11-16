//
//  BaseTableViewCell.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Reusable
import UIKit

class BaseTableViewCell: UITableViewCell, Reusable {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initialize()
    self.setLayouts()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.initialize()
    self.setLayouts()
  }
  
  
  func initialize() {
    fatalError("initialize has not been implemented")
  }
  
  func setLayouts() {
    fatalError("setLayouts has not been implemented")
  }
}
