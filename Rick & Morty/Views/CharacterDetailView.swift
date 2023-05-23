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
  public var collectionView: UICollectionView?
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()
  private let viewModel: CharacterDetailViewViewModel

  // MARK: - Init's
  init(frame: CGRect, viewModel: CharacterDetailViewViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
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
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }

  private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
    let sectionTypes = viewModel.sections
    switch sectionTypes[sectionIndex] {
    case .photo:
      return createSectionLayout()
    case .information:
      return createSectionLayout()
    case .episodes:
      return createSectionLayout()
    }
  }

  private func createSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                 leading: 0,
                                                 bottom: 10,
                                                 trailing: 0)
    let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                    heightDimension: .absolute(160)),
                                                 subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
}
