//
//  NewBooksCollectionViewCell.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import ActiveLabel
import Reusable
import RxSwift
import SnapKit
import SDWebImage
import Then
import UIKit

class NewBooksTableViewCell: UITableViewCell, Reusable {
  private static var imageWidth: CGFloat = 0
  
  private let titleLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 17)
    $0.textColor = .black
  }
  private let subtitleLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 13)
    $0.textColor = .gray
  }
  private let bookImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  private let priceLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 13)
    $0.textColor = .black
  }
  private let isbn13Label = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 13)
    $0.textColor = .black
  }
  private let urlLabel = ActiveLabel().then {
    $0.enabledTypes = [.url]
    $0.font = UIFont.systemFont(ofSize: 12)
  }
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 3
    $0.distribution = .fillEqually
  }
  
  private var urlTapSignal = PublishSubject<URL>()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initialize()
    self.setLayouts()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initialize() {
    self.contentView.addSubview(self.bookImageView)
    self.stackView.addArrangedSubview(self.titleLabel)
    self.stackView.addArrangedSubview(self.subtitleLabel)
    self.stackView.addArrangedSubview(self.isbn13Label)
    self.stackView.addArrangedSubview(self.priceLabel)
    self.stackView.addArrangedSubview(self.urlLabel)
    self.contentView.addSubview(self.stackView)
    
    self.urlLabel.handleURLTap { [weak self] (url) in
      self?.urlTapSignal.onNext(url)
    }
  }
  
  func setLayouts() {
    self.bookImageView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview()
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.width.equalTo(self.bookImageView.snp.height)
    }
    
    self.stackView.snp.makeConstraints { (make) in
      make.leading.equalTo(self.bookImageView.snp.trailing)
      make.top.equalToSuperview().inset(20)
      make.trailing.equalToSuperview().inset(10)
      make.bottom.equalToSuperview().inset(20)
    }
  }
  
  func configure(book: Book) {
    self.titleLabel.text = book.title
    self.subtitleLabel.text = book.subtitle
    self.priceLabel.text = book.price
    self.isbn13Label.text = book.isbn13
    self.urlLabel.text = book.url
    
    if let imageUrlString = book.image,
      let url = URL(string: imageUrlString) {
      self.bookImageView.sd_setImage(
        with: url,
        placeholderImage: UIImage(named: "placeholder"),
        options: .retryFailed,
        context: nil
      )
    } else {
      self.bookImageView.image = UIImage(named: "placeholder")
    }
  }
  
  func signalForLink() -> Observable<URL> {
    self.urlTapSignal = PublishSubject<URL>()
    return self.urlTapSignal.asObservable()
  }
  
  static func cellHeight(fit width: CGFloat) -> CGFloat {
    return (width / 5) * 2
  }
}
