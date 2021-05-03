//
//  Alerts.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 03.05.2021.
//

import UIKit

/// The place for setting up alerts.

extension UIViewController {
  func showLoadingErrorAlert() {
    let alert = UIAlertController(title: "Error", message: "The application failed to download data.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dissmiss", style: .default, handler: nil))
    present(alert, animated: true)
  }
}
