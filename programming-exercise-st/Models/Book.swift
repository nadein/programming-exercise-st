//
//  Book.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import Foundation

struct Book: Decodable {
  let id: String
  let title: String
  let authors: [Author]
  let narrators: [Narrator]
  let cover: Cover
}
