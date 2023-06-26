//
//  EpisodeDetailView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 14.06.2023.
//

import UIKit

final class EpisodeDetailView: UIView {

  // MARK: - Properties
  private var viewModel: EpisodeDetailViewViewModel? {
    didSet {
      spinner.stopAnimating()
      self.collectionView?.reloadData()
      self.collectionView?.isHidden = false
      UIView.animate(withDuration: 0.3) {
        self.collectionView?.alpha = 1
      }
    }
  }

  private var collectionView: UICollectionView?

  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.hidesWhenStopped = true
    return spinner
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
    let collectionView = createCollectionView()
    addSubviews(collectionView, spinner)
    self.collectionView = collectionView
    addConstraints()
    spinner.startAnimating()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private  func addConstraints() {
    guard let collectionView else { return }
    NSLayoutConstraint.activate([
      spinner.heightAnchor.constraint(equalToConstant: 100),
      spinner.widthAnchor.constraint(equalToConstant: 100),
      spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      collectionView.leftAnchor.constraint(equalTo: leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }

  private func createCollectionView() -> UICollectionView {
    let layout = UICollectionViewCompositionalLayout { section, _ in
      return self.layout(for: section)
    }
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.isHidden = true
    collectionView.alpha = 0
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(EpisodeInfoCollectionViewCell.self,
                            forCellWithReuseIdentifier: EpisodeInfoCollectionViewCell.identifier)
    collectionView.register(CharacterCollectionViewCell.self,
                            forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    return collectionView
  }

  public func configure(with viewModel: EpisodeDetailViewViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - CollecttionView Delegate & DataSource Extension
extension EpisodeDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel?.cellViewModels.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sections = viewModel?.cellViewModels else { return 0 }
    let sectionType = sections[section]
    switch sectionType {
    case .information(viewModel: let viewModels):
      return viewModels.count
    case .characters(viewModel: let viewModels):
      return viewModels.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

  }
}

// MARK: - Layout Extension
extension EpisodeDetailView {
  private func layout(for section: Int) -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                 leading: 10,
                                                 bottom: 10,
                                                 trailing: 10)
    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                   heightDimension: .absolute(100)),
                                                 subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
}
