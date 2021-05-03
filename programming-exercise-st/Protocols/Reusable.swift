//
//  Reusable.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 02.05.2021.
//

import UIKit

/// Simplifies registring and reusing UITableViewCell objects.

protocol Reusable {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}

extension UITableView {
  func register<T: UITableViewCell>(_ : T.Type) where T: Reusable {
    register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeue<T: UITableViewCell>(_ : T.Type, for indexPath: IndexPath) -> T where T: Reusable {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      abort()
    }
    return cell
  }
}
