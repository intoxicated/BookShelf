//
//  MainTabBarController.swift
//  SendbirdProject
//
//  Created by R3alFr3e on 11/13/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initTabs()
  }
  
  private func initTabs() {
    let newBooksView = NewBooksRouter.createModule()
    newBooksView.tabBarItem = UITabBarItem(
      title: "",
      image: nil,
      selectedImage: nil
    )
    let searchView = SearchBooksRouter.createModule()
    searchView.tabBarItem = UITabBarItem(
      title: "",
      image: nil,
      selectedImage: nil
    )

    self.viewControllers = [
      UINavigationController(rootViewController: newBooksView),
      UINavigationController(rootViewController: searchView)
    ]
    
    self.tabBar.items?[0].title = "New Books"
    self.tabBar.items?[1].title = "Search"
  }
}
