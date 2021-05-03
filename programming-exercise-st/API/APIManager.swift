//
//  APIManager.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 01.05.2021.
//

import Foundation
import Moya // Networking library

final class APIManager: NSObject {
  let provider = MoyaProvider<StorytelAPI>()
  
  func getInitialPageWith(query: String, success: @escaping ([Book], Int?) -> Void, failure: @escaping (Error) -> Void) {
    provider.request(.initialPage(query: query)) { result in
      switch result {
      case .success(let response):
        do {
          let successfullResponse = try response.filterSuccessfulStatusCodes()
          let books = try successfullResponse.map([Book].self, atKeyPath: "items")
          let nextPageToken = try successfullResponse.map(String?.self, atKeyPath: "nextPageToken")
          success(books, Int(nextPageToken ?? ""))
        } catch {
          failure(error)
        }
      case .failure(let error):
        failure(error)
      }
    }
  }
  
  func getNextPageWith(query: String, pageToken: Int, success: @escaping ([Book], Int?) -> Void, failure: @escaping (Error) -> Void) {
    provider.request(.nextPage(query: query, pageToken: pageToken)) { result in
      switch result {
      case .success(let response):
        do {
          let successfullResponse = try response.filterSuccessfulStatusCodes()
          let books = try successfullResponse.map([Book].self, atKeyPath: "items")
          let nextPageToken = try successfullResponse.map(String?.self, atKeyPath: "nextPageToken")
          success(books, Int(nextPageToken ?? ""))
        } catch {
          failure(error)
        }
      case .failure(let error):
        failure(error)
      }
    }
  }
}
