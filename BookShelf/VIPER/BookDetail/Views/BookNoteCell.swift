//
//  BookNoteCell.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit
import RxSwift

class BookNoteCell: BaseTableViewCell {
  private let titleLabel = UILabel().then {
    $0.text = "Note"
    $0.font = UIFont.boldSystemFont(ofSize: 14)
  }
  private let textView = UITextView().then {
    $0.layer.cornerRadius = 6
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.gray.cgColor
  }
  private let saveButton = UIButton(type: .system).then {
    $0.setTitle("Save", for: .normal)
  }
  
  private var saveSignal = PublishSubject<String?>()
  private var note: String? = ""
  
  override func initialize() {
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.textView)
    self.contentView.addSubview(self.saveButton)
    
    self.textView.rx.text
      .subscribe(onNext: { [weak self] (text) in
        self?.saveButton.isEnabled = self?.note != text
      }).disposed(by: self.disposeBag)
    
    self.saveButton
      .rxForClick()
      .subscribe(onNext: { [weak self] (_) in
        self?.note = self?.textView.text
        self?.saveSignal.onNext(self?.textView.text)
      })
      .disposed(by: self.disposeBag)
  }
  
  override func setLayouts() {
    self.titleLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().inset(6)
      make.leading.equalToSuperview().inset(20)
      make.trailing.equalToSuperview().inset(20)
    }
    
    self.textView.snp.makeConstraints { (make) in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
      make.leading.equalToSuperview().inset(20)
      make.trailing.equalToSuperview().inset(20)
      make.height.equalTo(200)
    }
    
    self.saveButton.snp.makeConstraints { (make) in
      make.top.equalTo(self.textView.snp.bottom)
      make.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(12)
    }
  }
  
  func configure(text: String?) {
    self.note = text
    self.textView.text = text
    self.saveButton.isEnabled = false
  }
  
  func signalForSave() -> Observable<String?> {
    self.saveSignal = PublishSubject<String?>()
    return self.saveSignal.asObservable()
  }
}
