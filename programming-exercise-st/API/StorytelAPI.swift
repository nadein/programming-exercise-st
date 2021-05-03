//
//  StorytelAPI.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 01.05.2021.
//

import Foundation
import Moya // Networking library

/// Describing Storytel API in Moya style.

enum StorytelAPI {
  case initialPage(query: String)
  case nextPage(query: String, pageToken: Int)
}

extension StorytelAPI: TargetType {
  var baseURL: URL {
    URL(string: "https://api.storytel.net/")!
  }
  
  var path: String {
    "search/"
  }
  
  var method: Moya.Method {
    .get
  }
  
  var sampleData: Data {
    Data()
  }
  
  var task: Task {
    switch self {
    case .initialPage(let query):
      return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
    case .nextPage(let query, let pageToken):
      return .requestParameters(parameters: ["query": query, "page": pageToken], encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    .none
  }
}
