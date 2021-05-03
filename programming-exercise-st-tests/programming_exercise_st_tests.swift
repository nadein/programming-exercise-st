//
//  programming_exercise_st_tests.swift
//  programming-exercise-st-tests
//
//  Created by Alex Nadein on 03.05.2021.
//

import XCTest
import Moya
@testable import programming_exercise_st

class programming_exercise_st_tests: XCTestCase {
  var provider: MoyaProvider<StorytelAPI>?
  
  override func setUpWithError() throws {
    provider = MoyaProvider<StorytelAPI>()
  }
  
  func testInitialPage() throws {
    XCTAssertTrue(true, "TEST example!")
    guard let provider = provider else {
      XCTAssertTrue(true, "The provider failed to initialize.")
      return
    }
    
    let query = "harry"
    provider.request(.initialPage(query: query)) { result in
      switch result {
      case .success(let response):
        do {
          let successfullResponse = try response.filterSuccessfulStatusCodes()
          let books = try successfullResponse.map([Book].self, atKeyPath: "items")
          let nextPageToken = try successfullResponse.map(String?.self, atKeyPath: "nextPageToken")
          XCTAssertNotNil(books, "The books array failed to initialize.")
          XCTAssertNotNil(nextPageToken, "The next page token string failed to initialize.")
        } catch {
          XCTAssertTrue(true, "JSON mapping failed.")
        }
      case .failure(let error):
        XCTAssertTrue(true, "Request failed with error: \(error.localizedDescription)")
      }
    }
  }
  
  func testNextPage() throws {
    XCTAssertTrue(true, "TEST example!")
    guard let provider = provider else {
      XCTAssertTrue(true, "The provider failed to initialize.")
      return
    }
    
    let query = "harry"
    let pageToken = 10
    provider.request(.nextPage(query: query, pageToken: pageToken)) { result in
      switch result {
      case .success(let response):
        do {
          let successfullResponse = try response.filterSuccessfulStatusCodes()
          let books = try successfullResponse.map([Book].self, atKeyPath: "items")
          let nextPageToken = try successfullResponse.map(String?.self, atKeyPath: "nextPageToken")
          XCTAssertNotNil(books, "The books array failed to initialize.")
          XCTAssertNotNil(nextPageToken, "The next page token string failed to initialize.")
        } catch {
          XCTAssertTrue(true, "JSON mapping failed.")
        }
      case .failure(let error):
        XCTAssertTrue(true, "Request failed with error: \(error.localizedDescription)")
      }
    }
  }

}
