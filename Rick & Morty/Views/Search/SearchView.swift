//
//  SearchView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 09.09.2023.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
  func searchView(_ searchView: SearchView, didSelectOption option: SearchInputViewViewModel.DynamicOptions)
}

final class SearchView: UIView {

  // MARK: - Properties
  private let viewModel: SearchViewViewModel
  weak var delegate: SearchViewDelegate?

  // MARK: - Subview's
  private let noResultsView = NoSearchResultsView()
  private let searchInputView = SearchInputView()

  // MARK: - Init's
  init(frame: CGRect, viewModel: SearchViewViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    backgroundColor = .systemBackground
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(noResultsView, searchInputView)
    addConstraints()
    searchInputView.configure(with: .init(type: viewModel.config.type))
    searchInputView.delegate = self
    viewModel.registerOptionChangeBlock { tuple in
      self.searchInputView.update(option: tuple.0, value: tuple.1)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been impl emented")
  }

  //MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      searchInputView.topAnchor.constraint(equalTo: topAnchor),
      searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
      searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
      searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),

      noResultsView.widthAnchor.constraint(equalToConstant: 150),
      noResultsView.heightAnchor.constraint(equalToConstant: 150),
      noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
      noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }

  public func presentKeeyboard() {
    searchInputView.presentKeyboard()
  }
}

// MARK: - CollectionView Delegate Protocol Extension
extension SearchView: UICollectionViewDelegate {
}

// MARK: - CollectionViewDataSouce Protocol Extension
extension SearchView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
  }
}

// MARK: - SearchInputViewDelegate Extension
extension SearchView: SearchInputViewDelegate {
  func searchInputViewDidTapSearchKeyboard(_ inputView: SearchInputView) {
    viewModel.executeSearch()
  }
  
  func searchInputView(_ inputView: SearchInputView, didChangeSearchText text: String) {
    viewModel.set(query: text)
  }
  
  func searchInputView(_ inputView: SearchInputView, didSelectOption option: SearchInputViewViewModel.DynamicOptions) {
    delegate?.searchView(self, didSelectOption: option)
  }
}
