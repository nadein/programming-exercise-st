//
//  BooksViewModel.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import Foundation

// MARK: - BooksViewModelDelegate
protocol BooksViewModelDelegate: AnyObject {
  func viewModel(_ viewModel: BooksViewModel, didLoad data: [BookCell.ViewModel])
  func viewModelDidFinishLoading()
  func viewModel(_ viewModel: BooksViewModel, didFailedLoadingWith error: Error)
}

// MARK: - BooksViewModel
final class BooksViewModel: NSObject {
  
  // MARK: Properties
  weak var delegate: BooksViewModelDelegate?
  var apiService: APIManager
  var query: String
  var nextPageToken: Int?
  
  private var books: [Book] = [] {
    didSet {
      DispatchQueue.main.async {
        self.delegate?.viewModel(self, didLoad: self.books.map { book in
          return BookCell.ViewModel(
            id: book.id,
            title: book.title,
            authors: "by " + book.authors.map({ $0.name }).joined(separator: ", "),
            narrators: "with " + book.narrators.map({ $0.name }).joined(separator: ", "),
            cover: book.cover.url
          )
        })
      }
    }
  }
  
  // MARK: - Initialization
  init(apiService: APIManager, query: String) {
    self.apiService = apiService
    self.query = query
  }
  
  // MARK: - Public functions
  func viewDidLoad() {
    apiService.getInitialPageWith(query: query, success: weakify { booksPage, nextPageToken, safeSelf in
      safeSelf.nextPageToken = nextPageToken
      safeSelf.books = booksPage
    }, failure: weakify { error, safeSelf in
      safeSelf.delegate?.viewModel(safeSelf, didFailedLoadingWith: error)
    })
  }
  
  func nextPageReached() {
    guard let nextPageToken = nextPageToken else {
      delegate?.viewModelDidFinishLoading()
      return
    }
    apiService.getNextPageWith(query: query, pageToken: nextPageToken, success: weakify { booksPage, nextPageToken, safeSelf in
      safeSelf.nextPageToken = nextPageToken
      safeSelf.books += booksPage
    }, failure: weakify { error, safeSelf in
      safeSelf.delegate?.viewModel(safeSelf, didFailedLoadingWith: error)
    })
  }
}
