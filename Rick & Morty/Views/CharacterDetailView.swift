//
//  CharacterDetailView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 17.05.2023.
//

import UIKit

/// Vieew for single character
final class CharacterDetailView: UIView {
  // MARK: - Properties
  private var collectionView: UICollectionView?
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    let collectionView = createCollectionView()
    self.collectionView = collectionView
    addSubviews(collectionView, spinner)
    addConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func addConstraints() {
    guard let collectionView else { return }
    NSLayoutConstraint.activate([
      spinner.widthAnchor.constraint(equalToConstant: 100),
      spinner.heightAnchor.constraint(equalToConstant: 100),
      spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leftAnchor.constraint(equalTo: leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  private func createCollectionView() -> UICollectionView {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
      return self.createSection(for: sectionIndex)
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    return collectionView
  }

  private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {

  }
}
