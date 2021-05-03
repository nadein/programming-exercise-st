//
//  Author.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 01.05.2021.
//

import Foundation

typealias Narrator = Author

struct Author: Decodable {
  let id: String
  let name: String
}
