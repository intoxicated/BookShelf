//
//  BookMiscInfoCell.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import ActiveLabel
import RxSwift
import UIKit

class BookMiscCell: BaseTableViewCell {
  private let urlLabel = ActiveLabel().then {
    $0.enabledTypes = [.url]
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.numberOfLines = 0
  }
  private let pdfLabel = ActiveLabel().then {
    $0.enabledTypes = [.url]
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.numberOfLines = 0
  }
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 5
  }
  
  private var linkSignal = PublishSubject<URL>()
  
  override func initialize() {
    self.stackView.addArrangedSubview(self.urlLabel)
    self.stackView.addArrangedSubview(self.pdfLabel)
    self.contentView.addSubview(self.stackView)
    
    self.pdfLabel.handleURLTap { [weak self] (url) in
      self?.linkSignal.onNext(url)
    }
    
    self.urlLabel.handleURLTap { [weak self] (url) in
      self?.linkSignal.onNext(url)
    }
  }
  
  override func setLayouts() {
    self.stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(6)
      make.leading.equalToSuperview().inset(20)
      make.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(6)
    }
  }
  
  func configure(with model: BookMiscCellModel) {
    self.urlLabel.text = model.url
    self.pdfLabel.text = model.pdfs
  }
  
  func signalForLink() -> Observable<URL> {
    self.linkSignal = PublishSubject<URL>()
    return self.linkSignal.asObservable()
  }
}
