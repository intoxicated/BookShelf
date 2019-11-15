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
      title: "New Books",
      image: nil,
      selectedImage: nil
    )
    let searchView = NewBooksRouter.createModule()
    searchView.tabBarItem = UITabBarItem(
      title: "Search",
      image: nil,
      selectedImage: nil
    )

    self.tabBar.isTranslucent = false
    self.viewControllers = [
      UINavigationController(rootViewController: newBooksView),
      UINavigationController(rootViewController: searchView)
    ]
  }
}
