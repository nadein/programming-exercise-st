//
//  ViewController.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import UIKit

final class BooksViewController: UIViewController {
  
  // MARK: - Properties
  private let contentView = BooksView()
  private let dataSource = BooksDataSource()
  private let viewModel: BooksViewModel
  
  // MARK: - Initialization
  init(viewModel: BooksViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UIViewController override
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegates()
    setupTableView()
    setupEmptyState()
    viewModel.viewDidLoad()
  }
  
  override func loadView() {
    view = contentView
  }
  
  // MARK: - Configuration
  private func setupDelegates() {
    viewModel.delegate = self
  }
  
  private func setupTableView() {
    dataSource.queryText = viewModel.query
    dataSource.onReachingNextPage = weakify { safeSelf in
      safeSelf.viewModel.nextPageReached()
    }
    contentView.tableView.register(BookCell.self)
    contentView.tableView.dataSource = dataSource
    contentView.tableView.delegate = dataSource
  }
  
  private func setupEmptyState() {
    contentView.emptyStateView.buttonAction = weakify { safeSelf in
      safeSelf.viewModel.viewDidLoad()
      safeSelf.contentView.emptyStateView.hide()
    }
  }
}

// MARK: - DiscoverViewModel Delegate
extension BooksViewController: BooksViewModelDelegate {
  func viewModel(_ viewModel: BooksViewModel, didFailedLoadingWith error: Error) {
    showLoadingErrorAlert()
  }
  
  func viewModelDidFinishLoading() {
    dataSource.stopLoading(contentView.tableView)
  }
  
  func viewModel(_ viewModel: BooksViewModel, didLoad data: [BookCell.ViewModel]) {
    dataSource.reloadTableView(contentView.tableView, with: data)
    if data.isEmpty {
      contentView.emptyStateView.show()
    } else {
      contentView.emptyStateView.hide()
    }
  }
}
