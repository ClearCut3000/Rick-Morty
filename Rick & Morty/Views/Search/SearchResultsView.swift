//
//  SearchResultsView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 28.06.2024.
//

import UIKit

// Shows search results UI
final class SearchResultsView: UIView {

  // MARK: - Properties
  private var viewModel: SearchResultViewModel? {
    didSet {
      self.processViewModel()
    }
  }

  // MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(LocationTableViewCell.self,
                       forCellReuseIdentifier: LocationTableViewCell.identifier)
    tableView.isHidden = true
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    isHidden = true
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(tableView)
    addConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: leftAnchor),
      tableView.rightAnchor.constraint(equalTo: rightAnchor),
    ])
  }

  private func processViewModel() {
    guard let viewModel else { return }
    switch viewModel {
    case .characters(let viewModels):
      setupCollectionView()
    case .episodes(let viewModels):
      setupCollectionView()
    case .locations(let viewModels):
      setupTableView()
    }
  }

  private func setupCollectionView() {

  }

  private func setupTableView() {
    tableView.isHidden = false
  }

  public func configure(with viewModel: SearchResultViewModel) {

  }
}
