//
//  EmptyStateView.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import UIKit

final class EmptyStateView: UIView {
  
  // MARK: - Subviews
  let label: UILabel = {
    let this = UILabel()
    this.translatesAutoresizingMaskIntoConstraints = false
    this.textAlignment = .center
    this.textColor = UIColor.darkText
    this.numberOfLines = 0
    this.font = .systemFont(ofSize: 20)
    this.text = "Nothing to display."
    return this
  }()
  let discoverButton: UIButton = {
    let this = UIButton()
    this.backgroundColor = .systemBlue
    this.layer.cornerRadius = 4.0
    this.clipsToBounds = true
    this.translatesAutoresizingMaskIntoConstraints = false
    this.setTitle("Reload", for: .normal)
    this.addTarget(self, action: #selector(discoverButtonAction), for: .touchUpInside)
    return this
  }()
  
  // MARK: - Initialization
  convenience init() {
    self.init(frame: .zero)
    configureView()
    configureSubviews()
    configureConstraints()
  }
  
  // MARK: - Actions
  var buttonAction: (() -> Void)?
  
  @objc private func discoverButtonAction(sender: UIButton!) {
    buttonAction?()
  }
  
  // MARK: - Public functions
  public func show() {
    self.isHidden = false
  }
  
  public func hide() {
    self.isHidden = true
  }
  
  // MARK: - Private functions
  private func configureView() {
    backgroundColor = .white
  }
  
  private func configureSubviews() {
    self.addSubview(label)
    self.addSubview(discoverButton)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
      label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
      
      discoverButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
      discoverButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
      discoverButton.widthAnchor.constraint(equalToConstant: 100)
    ])
  }
}

