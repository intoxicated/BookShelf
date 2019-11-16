//
//  BookDetailView.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/16/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

class BookDetailView: BaseViewController {
  var presenter: BookDetailPresenterProtocol?
  var book: Book!
  
  private enum Row: Int {
    case basicInfo
    case detailInfo
    case misc
  }
  
  private struct Constants {
    static let numberOfRows = 3
  }
  
  private let tableView = UITableView().then {
    $0.separatorStyle = .none
    $0.register(cellType: BookBasicCell.self)
    $0.register(cellType: BookDetailCell.self)
    $0.register(cellType: BookMiscCell.self)
  }
  
  private var didLoad = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initNavigationView()
    self.initViews()
    self.presenter?.fetch()
  }
  
  func initNavigationView() {
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
      navBarAppearance.backgroundColor = .white

      navigationController?.navigationBar.standardAppearance = navBarAppearance
      navigationController?.navigationBar.compactAppearance = navBarAppearance
      navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

      navigationController?.navigationBar.prefersLargeTitles = true
      navigationController?.navigationBar.isTranslucent = false
    } else {
      UINavigationBar.appearance().barTintColor = .white
      UINavigationBar.appearance().isTranslucent = false
    }
    
    self.navigationItem.title = "Details"
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
        x: 0, y: 0,
        width: self.view.bounds.width,
        height: 400
      )
      self.tableView.tableHeaderView = imageView
    }
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
}

extension BookDetailView: BookDetailViewProtocol {
  func display(book: Book) {
    self.didLoad = true
    self.book = book
    self.tableView.reloadData()
  }
  
  func displayError(_ error: Error) {
    //display alert
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
    }
  }
}
