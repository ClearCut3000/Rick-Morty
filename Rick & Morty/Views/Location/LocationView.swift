//
//  LocationView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 26.08.2023.
//

import UIKit

final class LocationView: UIView {

  // MARK: - Properties
  private let table: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.alpha = 0
    table.isHidden = true
    table.register(UITableViewCell.self,
                   forCellReuseIdentifier: "cell")
    return table
  }()

  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.hidesWhenStopped = true
    return spinner
  }()

// MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(table, spinner)
    spinner.startAnimating()
    addConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

// MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      spinner.heightAnchor.constraint(equalToConstant: 100),
      spinner.widthAnchor.constraint(equalToConstant: 100),
      spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

      table.topAnchor.constraint(equalTo: topAnchor),
      table.leftAnchor.constraint(equalTo: leftAnchor),
      table.rightAnchor.constraint(equalTo: rightAnchor),
      table.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}
