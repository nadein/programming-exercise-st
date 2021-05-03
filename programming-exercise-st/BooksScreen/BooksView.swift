//
//  BooksView.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import UIKit

final class BooksView: UIView {
  
  // MARK: - Subviews
  let tableView: UITableView = {
    let this = UITableView(frame: .zero, style: .grouped)
    this.translatesAutoresizingMaskIntoConstraints = false
    this.backgroundColor = .white
    return this
  }()
  let emptyStateView: EmptyStateView = {
    let this = EmptyStateView()
    this.translatesAutoresizingMaskIntoConstraints = false
    return this
  }()
  
  // MARK: - Initialization
  convenience init() {
    self.init(frame: .zero)
    configureView()
    configureSubviews()
    configureConstraints()
  }
  
  // MARK: - Configuration
  private func configureView() {
    backgroundColor = .white
  }
  
  private func configureSubviews() {
    addSubview(tableView)
    addSubview(emptyStateView)
    emptyStateView.hide()
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      
      emptyStateView.topAnchor.constraint(equalTo: tableView.topAnchor),
      emptyStateView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
      emptyStateView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
      emptyStateView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
    ])
  }
}
