//
//  QueryHeader.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 03.05.2021.
//

import UIKit

final class QueryHeader: UILabel {
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }
  
  func commonInit() {
    self.backgroundColor = .white
    self.textColor = .darkText
    self.textAlignment = .center
  }
}
