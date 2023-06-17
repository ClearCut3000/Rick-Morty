//
//  EpisodeListView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 17.06.2023.
//

import UIKit

protocol EpisodeListViewDelegate: AnyObject {
  func rmEpisodeListViewDelegate(_ episodeListView: EpisodeListView,
                           didSelectEpisode episode: Episode)
}

/// View that handles list of characters, loader, etc.
final class EpisodeListView: UIView {

  // MARK: - Properties
  public weak var delegate: EpisodeListViewDelegate?
  private let viewModel = EpisodeListViewViewModel()
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isHidden = true
    collectionView.alpha = 0
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    collectionView.register(FooterLoadingCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                            withReuseIdentifier: FooterLoadingCollectionReusableView.identtifier)
    return collectionView
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(collectionView, spinner)
    addConstraints()
    spinner.startAnimating()
    viewModel.delegate = self
    viewModel.fetchCharacters()
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

// MARK: - CharacterListViewViewModel Protocol Delegate
extension EpisodeListView: EpisodeListViewViewModelDelegate {
  func didSelectEpisode(_ episode: Episode) {
    delegate?.rmEpisodeListView(self, didSelectEpisode: episode)
  }

  func didLoadInitialCharacters() {
    spinner.stopAnimating()
    collectionView.isHidden = false
    collectionView.reloadData()
    UIView.animate(withDuration: 0.4) {
      self.collectionView.alpha = 1
    }
  }

  func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
    collectionView.performBatchUpdates {
      self.collectionView.insertItems(at: newIndexPaths)
    }
  }
}

