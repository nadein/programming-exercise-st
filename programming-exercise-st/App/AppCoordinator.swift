//
//  AppCoordinator.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import UIKit

/// App's entry point.

final class AppCoordinator {
  private let apiService = APIManager()
  private let window: UIWindow
  private var navigationController: UINavigationController?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let viewController = BooksViewController(viewModel: .init(apiService: apiService, query: "harry"))
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
}
