//
//  NewBooksView.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit

class NewBooksView: BaseViewController {
  var presenter: NewBooksPresenterProtocol?
  
  private let tableView = UITableView().then {
    $0.register(cellType: NewBooksTableViewCell.self)
  }
  
  private var books: [Book] = []
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initNavigationView()
    self.initViews()
    self.presenter?.fetch()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.tableView.snp.makeConstraints { (make) in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  func initNavigationView() {
    self.title = "New"
    self.navigationItem.title = ""
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.barTintColor = .white
    self.navigationController?.navigationBar.isTranslucent = false
  }
  
  func initViews() {
    let headerView = UIView()
    let titleLabel = UILabel().then {
      $0.font = UIFont.boldSystemFont(ofSize: 30)
      $0.text = "New Books"
    }
    headerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(10)
    }
    
    headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
    self.tableView.tableHeaderView = headerView
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.view.addSubview(self.tableView)
  }
}

extension NewBooksView: NewBooksViewProtocol {
  func display(books: [Book]) {
    self.books = books
    self.tableView.reloadData()
  }
  
  func displayError(_ error: Error) {
    //display alert
  }
}

extension NewBooksView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.books.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return NewBooksTableViewCell.cellHeight(fit: tableView.bounds.width)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let book = self.books[indexPath.row]
    let cell: NewBooksTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.configure(book: book)
    cell.signalForLink().subscribe(onNext: { [weak self] (url) in
      self?.presenter?.didClickOnLink(url, from: self)
    }).disposed(by: self.disposeBag)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter?.didClickOnBook(self.books[indexPath.row], from: self)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 50 {
      UIView.animate(withDuration: 0.3) {
        self.navigationItem.title = "New Books"
      }
    } else {
      UIView.animate(withDuration: 0.3) {
        self.navigationItem.title = ""
      }
    }
  }
}
