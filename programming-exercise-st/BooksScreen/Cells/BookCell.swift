//
//  BookCell.swift
//  programming-exercise-st
//
//  Created by Alex Nadein on 29.04.2021.
//

import UIKit
import Kingfisher // Caching library

final class BookCell: UITableViewCell, Reusable {
  
  // MARK: - Subviews
  let titleLabel: UILabel = {
    let this = UILabel()
    this.translatesAutoresizingMaskIntoConstraints = false
    this.textAlignment = .left
    this.textColor = UIColor.black
    this.numberOfLines = 0
    this.font = .boldSystemFont(ofSize: 14)
    return this
  }()
  
  let authorsLabel: UILabel = {
    let this = UILabel()
    this.translatesAutoresizingMaskIntoConstraints = false
    this.textAlignment = .left
    this.textColor = UIColor.darkGray
    this.numberOfLines = 0
    this.font = .boldSystemFont(ofSize: 14)
    return this
  }()
  
  let narratorsLabel: UILabel = {
    let this = UILabel()
    this.translatesAutoresizingMaskIntoConstraints = false
    this.textAlignment = .left
    this.textColor = UIColor.darkGray
    this.numberOfLines = 0
    this.font = .boldSystemFont(ofSize: 14)
    return this
  }()
  
  let coverView: UIImageView = {
    let this = UIImageView()
    this.translatesAutoresizingMaskIntoConstraints = false
    this.contentMode = .scaleAspectFit
    return this
  }()
  
  // MARK: - Initialization
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureView()
    configureSubviews()
    configureConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  private func configureView() {
    contentView.backgroundColor = .white
  }
  
  private func configureSubviews() {
    contentView.addSubview(coverView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(authorsLabel)
    contentView.addSubview(narratorsLabel)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      coverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
      coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      coverView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
      coverView.widthAnchor.constraint(equalToConstant: 100),
      
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      titleLabel.heightAnchor.constraint(equalToConstant: 20),
      
      authorsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      authorsLabel.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: 8),
      authorsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      authorsLabel.heightAnchor.constraint(equalToConstant: 20),
      
      narratorsLabel.topAnchor.constraint(equalTo: authorsLabel.bottomAnchor, constant: 16),
      narratorsLabel.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: 8),
      narratorsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      narratorsLabel.heightAnchor.constraint(equalToConstant: 20),
    ])
  }
}

// MARK: - View Model
extension BookCell {
  struct ViewModel: Hashable {
    let id: String
    let title: String
    let authors: String
    let narrators: String
    let cover: String
  }
  
  func populate(data: ViewModel) {
    titleLabel.text = data.title
    authorsLabel.text = data.authors
    narratorsLabel.text = data.narrators
    let url = URL(string: data.cover)
    coverView.kf.setImage(with: url) // caching image for optimizing downloads
  }
}

