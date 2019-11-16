//
//  BookDetailBasicInfoCell.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import Reusable
import Cosmos

class BookBasicCell: BaseTableViewCell {
  private let titleAndYearLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 24)
    $0.numberOfLines = 0
  }
  private let subtitleLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.numberOfLines = 0
  }
  private let authorsLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.numberOfLines = 0
  }
  private let ratingView = CosmosView().then {
    $0.settings.starSize = 20
    $0.settings.starMargin = 5
    $0.settings.filledColor = .yellow
  }
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 5
  }
  
  override func initialize() {
    self.stackView.addArrangedSubview(self.titleAndYearLabel)
    self.stackView.addArrangedSubview(self.subtitleLabel)
    self.stackView.addArrangedSubview(self.authorsLabel)
    self.stackView.addArrangedSubview(self.ratingView)
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
  
  func configure(with model: BookBasicCellModel) {
    self.titleAndYearLabel.text = model.titleAndYear
    self.subtitleLabel.text = model.subtitle
    self.authorsLabel.text = model.authors
    self.ratingView.rating = model.rating
  }
}
