//
//  EpisodeDetailView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 14.06.2023.
//

import UIKit

final class EpisodeDetailView: UIView {

  // MARK: - Properties
  private var viewModel: EpisodeDetailViewViewModel?

  private var collectionView: UICollectionView?

  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
    self.collectionView = createCollectionView()
    addConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private  func addConstraints() {
    NSLayoutConstraint.activate([

    ])
  }

  private func createCollectionView() -> UICollectionView {
    let layout = UICollectionViewCompositionalLayout { section, _ in
      return self.layout(for: section)
    }
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }

  public func configure(with viewModel: EpisodeDetailViewViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - Layout Extension
extension EpisodeDetailView {
  private func layout(for section: Int) -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1)))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                   heightDimension: .fractionalHeight(1)),
                                                 subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
}
