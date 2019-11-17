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

class NewBooksView: BaseViewController, ZoomInOutAnimatable {
  var presenter: NewBooksPresenterProtocol?
  
  private let tableView = UITableView().then {
    $0.separatorStyle = .none
    $0.register(cellType: BookTableViewCell.self)
  }
  
  private var books: [Book] = []
  var targetView: UIView?
  
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
      // Fallback on earlier versions
      UINavigationBar.appearance().barTintColor = .white
      UINavigationBar.appearance().isTranslucent = false
    }
    
    self.title = "New"
    self.navigationItem.title = "New Books"
    self.navigationController?.delegate = self
  }
  
  func initViews() {
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
    return BookTableViewCell.cellHeight(fit: tableView.bounds.width)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let book = self.books[indexPath.row]
    let cell: BookTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    let model = BookTableViewCellModel(book: book)
    cell.configure(with: model)
    cell.signalForLink().subscribe(onNext: { [weak self] (url) in
      self?.presenter?.didClickOnLink(url, from: self)
    }).disposed(by: self.disposeBag)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! BookTableViewCell
    self.targetView = cell.bookImageView
    self.presenter?.didClickOnBook(self.books[indexPath.row], from: self)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension NewBooksView: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = ZoomInOutAnimator()
    animator.isPresenting = operation == .push
    return animator
  }
}
