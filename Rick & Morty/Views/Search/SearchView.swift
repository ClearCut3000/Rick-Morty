//
//  SearchView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 09.09.2023.
//

import UIKit

final class SearchView: UIView {

  // MARK: - Properties
  private let viewModel: SearchViewViewModel

  // MARK: - Subview's


  // MARK: - Init's
  init(frame: CGRect, viewModel: SearchViewViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
