//
//  EpisodeListViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 18.06.2023.
//

import UIKit

protocol EpisodeListViewViewModelDelegate: AnyObject {
  func didLoadInitialEpisode()
  func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
  func didSelectEpisode(_ episode: Episode)
}

/// View Model to handle episode list view logic
final class EpisodeListViewViewModel: NSObject {

  // MARK: - ViewModel Properties
  public weak var delegate: EpisodeListViewViewModelDelegate?

  public var isLoadingMoreEpisodes = false

  public var shouldShowLoadMoreIndicator: Bool {
    return apiInfo?.next != nil
  }

  private var episodes: [Episode] = [] {
    didSet {
      episodes.forEach { episode in
        let viewModel = CharacterEpisodeCollectionViewCellViewModel(episodeDataURL: URL(string: episode.url))
        if !cellViewModels.contains(viewModel) {
          cellViewModels.append(viewModel)
        }
      }
    }
  }

  private var cellViewModels: [CharacterEpisodeCollectionViewCellViewModel] = []

  private var apiInfo: GetAllEpisodesResponse.Info? = nil


  // MARK: - ViewModel Methods
  /// Sets initial amount of episodes(20)
  public func fetchEpisodes() {
    Service.shared.execute(.listEpisodeRequest,
                           expecting: GetAllEpisodesResponse.self) { [weak self] result in
      switch result {
      case .success(let responseModel):
        let results = responseModel.results
        let info = responseModel.info
        self?.episodes = results
        self?.apiInfo = info
        DispatchQueue.main.async {
          self?.delegate?.didLoadInitialEpisode()
        }
      case .failure(let error):
        print(String(describing: error))
      }
    }
  }

  /// Paginate if additional episodes  are needed
  public func fetchAdditionalEpisodes(url: URL) {
    guard !isLoadingMoreEpisodes else { return }
    isLoadingMoreEpisodes = true
    guard let request = Request(url: url) else { return }
    Service.shared.execute(request,
                           expecting: GetAllEpisodesResponse.self) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let success):
        let additionalResults = success.results
        let info = success.info
        self.apiInfo = info
        let originalCount = self.episodes .count
        let newCount = additionalResults.count
        let total = originalCount + newCount
        let startingIndex = total - newCount
        let indexPathToAdd: [IndexPath] = Array(startingIndex ..< (startingIndex + newCount)).compactMap {
          return IndexPath(row: $0, section: 0)
        }
        self.episodes.append(contentsOf: additionalResults)
        DispatchQueue.main.async {
          self.delegate?.didLoadMoreEpisodes(with: indexPathToAdd)
          self.isLoadingMoreEpisodes = false
        }
      case .failure(let failure):
        print(String(describing: failure))
        self.isLoadingMoreEpisodes = false
      }
    }
  }
}

// MARK: - CollectionView DataSource Protocol Extension
extension EpisodeListViewViewModel: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier,
                                                        for: indexPath) as? CharacterEpisodeCollectionViewCell else {
      fatalError("Unsupported Cell!")
    }
    cell.configure(with: cellViewModels[indexPath.row])
    return cell
  }
}

// MARK: - CollectionView Delegate Protocol Extension
extension EpisodeListViewViewModel: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let episode = episodes[indexPath.row]
    delegate?.didSelectEpisode(episode)
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionFooter,
          let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: FooterLoadingCollectionReusableView.identtifier,
                                                                       for: indexPath) as? FooterLoadingCollectionReusableView else {
      fatalError("Unsupported !")
    }
    footer.startAnimating()
    return footer
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    guard shouldShowLoadMoreIndicator else { return .zero }
    return CGSize(width: collectionView.frame.width, height: 100)
  }
}

// MARK: - CollectionView FlowLayout Protocol Extension
extension EpisodeListViewViewModel: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width - 30) / 2
    return CGSize(width: width, height: width * 0.8)
  }
}

// MARK: - ScrollViewDelegate Protocol Extension
extension EpisodeListViewViewModel: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldShowLoadMoreIndicator,
          !isLoadingMoreEpisodes,
          !cellViewModels.isEmpty,
          let nexURLString = apiInfo?.next,
          let url = URL(string: nexURLString) else { return }
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
      let offset = scrollView.contentOffset.y
      let totalContentHeight = scrollView.contentSize.height
      let totalScrollViewFixedHeight = scrollView.frame.size.height
      if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
        self?.fetchAdditionalEpisodes(url: url)
      }
      timer.invalidate()
    }
  }
}

