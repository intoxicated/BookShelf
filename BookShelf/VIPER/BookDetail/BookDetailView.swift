//
//  BookDetailView.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift
import UIKit

class BookDetailView: BaseViewController, ZoomInOutAnimatable {
  var presenter: BookDetailPresenterProtocol?
  var book: Book!
  var targetView: UIView?
  
  private enum Row: Int {
    case basicInfo
    case detailInfo
    case misc
    case note
  }
  
  private struct Constants {
    static let numberOfRows = 4
  }
  
  private let tableView = UITableView().then {
    $0.separatorStyle = .none
    $0.register(cellType: BookBasicCell.self)
    $0.register(cellType: BookDetailCell.self)
    $0.register(cellType: BookMiscCell.self)
    $0.register(cellType: BookNoteCell.self)
  }
  
  private var didLoad = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initNavigationView()
    self.initViews()
    self.presenter?.fetch()
  }

  func initNavigationView() {
    self.navigationItem.title = "Details"
    self.navigationItem.largeTitleDisplayMode = .never
  }
  
  func initViews() {
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.view.addSubview(self.tableView)
    
    if let url = self.book.image {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.sd_setImage(
        with: url,
        placeholderImage: UIImage(named:"placeholder"),
        options: .retryFailed,
        completed: nil
      )
      imageView.frame = CGRect(
        x: 0, y: 88,
        width: self.view.bounds.width,
        height: 400
      )
      self.targetView = imageView
      self.tableView.tableHeaderView = self.targetView
    }
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}

extension BookDetailView: BookDetailViewProtocol {
  func display(book: Book) {
    self.didLoad = true
    self.book = book
    self.tableView.reloadData()
  }
  
  func displayError(_ error: BookShelfError) {
    NoticeController.shared.showAlert(
      with: error,
      from: self) { [weak self] (retry) in
        if retry {
          self?.presenter?.fetch()
        }
      }
  }
  
  func saveCompleted(success: Bool) {
    NoticeController.shared.showCompletion(
      with: "Saved!",
      message: "Your note has been saved",
      from: self
    )
    self.tableView.reloadData()
  }
}

extension BookDetailView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.didLoad ? 1 : 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.numberOfRows
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let row = Row(rawValue: indexPath.row) else {
      return UITableViewCell()
    }
    
    switch row {
    case .basicInfo:
      let cell: BookBasicCell = tableView.dequeueReusableCell(for: indexPath)
      let model = BookBasicCellModel(book: self.book)
      cell.configure(with: model)
      return cell
    case .detailInfo:
      let cell: BookDetailCell = tableView.dequeueReusableCell(for: indexPath)
      let model = BookDetailCellModel(book: self.book)
      cell.configure(with: model)
      return cell
    case .misc:
      let cell: BookMiscCell = tableView.dequeueReusableCell(for: indexPath)
      let model = BookMiscCellModel(book: self.book)
      cell.configure(with: model)
      cell.signalForLink().subscribe(onNext: { [weak self] (url) in
        self?.presenter?.didClickOnLink(url, from: self)
      }).disposed(by: self.disposeBag)
      return cell
    case .note:
      let cell: BookNoteCell = tableView.dequeueReusableCell(for: indexPath)
      self.book
        .getNote()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (note) in
          cell.configure(text: note?.text)
        }).disposed(by: self.disposeBag)
        
      cell.signalForSave().subscribe(onNext: { [weak self] text in
        self?.presenter?.didClickOnSaveForNote(text: text, from: self)
      }).disposed(by: self.disposeBag)
      return cell
    }
  }
}
