//
//  BooksDataSource.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 02.05.2021.
//

import UIKit

private struct Constants {
  static let cellHeight: CGFloat = 120.0
  static let headerHeight: CGFloat = 100.0
  static let spinnerHeight: CGFloat = 44.0
}

// In iOS 13+ can be replaced with UITableViewDiffableDataSource.

final class BooksDataSource: NSObject {
  
  // MARK: - Public properties
  var onReachingNextPage: (() -> Void)?
  var queryText: String?
  
  // MARK: - Private properties
  private var data = [BookCell.ViewModel]()
  private var isWaitingForNextPage = false
  private var shouldLoad = true
  private let spinner = UIActivityIndicatorView(style: .gray)
  
  // MARK: - Public functions
  func reloadTableView(_ tableView: UITableView, with data: [BookCell.ViewModel]) {
    self.data = data
    onGettingNextPage(tableView)
    tableView.reloadData()
  }
  
  func stopLoading(_ tableView: UITableView) {
    shouldLoad = false
    onGettingNextPage(tableView)
  }
  
  // MARK: - Private functions
  private func onReachingNextPage(_ tableView: UITableView, indexPath: IndexPath) {
    let lastRowIndex = data.count - 1
    if indexPath.row == lastRowIndex, shouldLoad, !isWaitingForNextPage, let onReachingNextPage = onReachingNextPage {
      isWaitingForNextPage = true
      spinner.startAnimating()
      spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: Constants.spinnerHeight)
      tableView.tableFooterView = spinner
      tableView.tableFooterView?.isHidden = false
      onReachingNextPage()
    }
  }
  
  private func onGettingNextPage(_ tableView: UITableView) {
    isWaitingForNextPage = false
    spinner.stopAnimating()
    tableView.tableFooterView?.isHidden = true
  }
}

// MARK: - UITableViewDataSource
extension BooksDataSource: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    onReachingNextPage(tableView, indexPath: indexPath)
    let cell = tableView.dequeue(BookCell.self, for: indexPath)
    cell.populate(data: data[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let queryText = queryText else { return .none }
    let header = QueryHeader()
    header.text = "Query: \(queryText)"
    return header
  }
}

// MARK: - UITableViewDelegate
extension BooksDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    Constants.cellHeight
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard queryText != nil else { return 0 }
    return Constants.headerHeight
  }
}
