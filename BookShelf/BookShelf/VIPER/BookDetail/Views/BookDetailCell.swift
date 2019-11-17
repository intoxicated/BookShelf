//
//  BookDetailInfoCell.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

class BookDetailCell: BaseTableViewCell {
  private let priceLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
  }
  private let publisherLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.numberOfLines = 0
  }
  private let pageLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
  }
  private let isbnsLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.numberOfLines = 0
  }
  private let descLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.numberOfLines = 0
  }
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 5
  }
  
  override func initialize() {
    self.stackView.addArrangedSubview(self.publisherLabel)
    self.stackView.addArrangedSubview(self.priceLabel)
    self.stackView.addArrangedSubview(self.pageLabel)
    self.stackView.addArrangedSubview(self.isbnsLabel)
    self.stackView.addArrangedSubview(self.descLabel)
    self.contentView.addSubview(self.stackView)
  }
  
  override func setLayouts() {
    self.stackView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().inset(6)
      make.leading.equalToSuperview().inset(20)
      make.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(6)
    }
  }
  
  func configure(with model: BookDetailCellModel) {
    self.publisherLabel.text = model.publisher
    self.priceLabel.text = model.price
    self.pageLabel.text = model.pages
    self.isbnsLabel.text = model.isbns
    self.descLabel.text = model.desc
  }
}
