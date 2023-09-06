//
//  LocationView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 26.08.2023.
//

import UIKit

final class LocationView: UIView {

  // MARK: - Properties:
  public private(set) var viewModel: LocationViewViewModel? {
    didSet {
      spinner.stopAnimating()
      table.isHidden = false
      table.reloadData()
      UIView.animate(withDuration: 0.3) {
        self.table.alpha = 1
      }
    }
  }

  // MARK: - Subview's
  private let table: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.alpha = 0
    table.isHidden = true
    table.register(LocationTableViewCell.self,
                   forCellReuseIdentifier: LocationTableViewCell.identifier)
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
    configureTable()
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

  public func configure(with viewModel: LocationViewViewModel) {
    self.viewModel = viewModel
  }

  private func configureTable() {
    table.delegate = self
    table.dataSource = self
  }
}

// MARK: - TableView Delegate Extension
extension LocationView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    // Notify Controller of selection
  }
}

// MARK: - TableView DataSource Extension
extension LocationView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.cellViewModels.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cellViewModels = viewModel?.cellViewModels else {
      fatalError()
    }
    guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {
      fatalError()
    }
    let cellViewModel = cellViewModels[indexPath.row]
    cell.textLabel?.text = cellViewModel.name
    return cell
  }
}
