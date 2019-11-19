//
//  SearchBooksView.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RxSwift
import Then
import UIKit

class SearchBooksView: BaseViewController, ZoomInOutAnimatable {
  var presenter: SearchBooksPresenterProtocol?
  
  private let searchController = UISearchController(searchResultsController: nil).then {
    $0.hidesNavigationBarDuringPresentation = true
    $0.obscuresBackgroundDuringPresentation = false
    $0.searchBar.placeholder = "Search books"
  }
  private let tableView = UITableView().then {
    $0.separatorStyle = .none
    $0.register(cellType: BookTableViewCell.self)
  }
  private var books: [Book] = []
  private var searching: Bool = false
  
  var targetView: UIView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initNavigationView()
    self.initViews()
  }
  
  override func setupConstraints() {
    self.tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }

  func initNavigationView() {
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
      navBarAppearance.backgroundColor = .white

      self.navigationController?.navigationBar.standardAppearance = navBarAppearance
      self.navigationController?.navigationBar.compactAppearance = navBarAppearance
      self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
      self.navigationController?.navigationBar.prefersLargeTitles = true
    } else {
      // Fallback on earlier versions
      UINavigationBar.appearance().barTintColor = .white
      UINavigationBar.appearance().isTranslucent = false
    }
    
    self.navigationItem.title = "Search"
    self.navigationItem.searchController = self.searchController
    self.definesPresentationContext = true
    self.navigationController?.delegate = self
    self.searchController.searchBar.delegate = self
    
    self.searchController.searchBar.rx.text
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] (text) in
        self?.requestSearch(with: text, fromScroll: false)
      }).disposed(by: self.disposeBag)
  }
  
  func initViews() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.view.addSubview(self.tableView)
  }
  
  func requestSearch(with text: String?, fromScroll: Bool) {
    guard self.searching == true else { return }
    self.tableView.showIndicatorTo(fromScroll ? .footer : .center)
    self.presenter?.search(with: text)
  }
}

extension SearchBooksView: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.searching = true
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    self.searching = false
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.searching = false
    self.books = []
    self.presenter?.reset()
    self.tableView.reloadData()
  }
}

extension SearchBooksView: SearchBooksViewProtocol {
  func display(books: [Book], isFirstRequest: Bool) {
    self.books = books
    self.tableView.reloadData()
    self.tableView.hideIndicator()
    
    if isFirstRequest {
      self.tableView.scrollToRow(
        at: IndexPath(row: 0, section: 0),
        at: .top,
        animated: false
      )
    }
  }
  
  func displayError(_ error: Error) {
    self.tableView.hideIndicator()
  }
}

extension SearchBooksView: UITableViewDataSource, UITableViewDelegate {
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
  
  func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath) {
    if indexPath.row == self.books.count - 1 {
      self.requestSearch(
        with: self.searchController.searchBar.text,
        fromScroll: true
      )
    }
  }
}

extension SearchBooksView: UINavigationControllerDelegate {
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
