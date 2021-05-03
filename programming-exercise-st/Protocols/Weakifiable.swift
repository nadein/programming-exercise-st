//
//  Weakifiable.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 02.05.2021.
//

import Foundation

/// Allows avoiding boilerplate in closures with weak self capture.

protocol Weakifiable: AnyObject {}

extension NSObject: Weakifiable {}

extension Weakifiable {
  // No arguments
  func weakify(_ code: @escaping (Self) -> Void) -> () -> Void {
    return { [weak self] in
      guard let self = self else { return }
      
      code(self)
    }
  }
  
  // One argument
  func weakify<T>(_ code: @escaping (T, Self) -> Void) -> (T) -> Void {
    return { [weak self] arg in
      guard let self = self else { return }
      
      code(arg, self)
    }
  }
  
  // Two arguments
  func weakify<T1, T2>(_ code: @escaping (T1, T2, Self) -> Void) -> (T1, T2) -> Void {
    return { [weak self] argOne, argTwo in
      guard let self = self else { return }
      
      code(argOne, argTwo, self)
    }
  }
}
