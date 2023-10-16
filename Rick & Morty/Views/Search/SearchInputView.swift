//
//  SearchInputView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 09.09.2023.
//

import UIKit

final class SearchInputView: UIView {

  //MARK: - Subview's
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search"
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()

  private var viewModel: SearchInputViewViewModel? {
    didSet {
      guard let viewModel = viewModel, viewModel.hasDynamicOptions else { return }
      let options = viewModel.options
      createOptionSelectionViews(options: options)
    }
  }

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(searchBar)
    addConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func addConstraint() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: topAnchor),
      searchBar.leftAnchor.constraint(equalTo: leftAnchor),
      searchBar.rightAnchor.constraint(equalTo: rightAnchor),
      searchBar.heightAnchor.constraint(equalToConstant: 58)
    ])
  }

  public func configure(with viewModel: SearchInputViewViewModel) {
    searchBar.placeholder = viewModel.searchPlaceholderText
  }

  private func createOptionSelectionViews(options: [SearchInputViewViewModel.DynamicOptions]) {
    for option in options {

    }
  }
}
