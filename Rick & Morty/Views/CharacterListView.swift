//
//  CharacterListView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 08.05.2023.
//

import UIKit

/// View that handles list of characters, loader, etc.
final class CharacterListView: UIView {

  // MARK: - Properties
  private let viewModel = CharacterListViewViewModel()
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isHidden = true
    collectionView.alpha = 0
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    return collectionView
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(collectionView, spinner)
    addConstraints()
    spinner.startAnimating()
    setupCollectionView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func addConstraints() {
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

  private func setupCollectionView() {
    collectionView.dataSource = viewModel
    collectionView.delegate = viewModel
  }
}
