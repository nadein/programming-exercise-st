//
//  AppDelegate.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var appCoordinator: AppCoordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = AppCoordinator(window: window!)
    appCoordinator?.start()
    return true
  }
}

