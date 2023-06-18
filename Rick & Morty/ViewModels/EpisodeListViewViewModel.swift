//
//  EpisodeListViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 18.06.2023.
//

import UIKit

protocol EpisodeListViewViewModelDelegate: AnyObject {
  func didLoadInitialEpisode()
  func didLoadMoreEpisode(with newIndexPaths: [IndexPath])
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

  private var cellViewModels: [CharacterEpisodeCollectionViewCell] = []

  private var apiInfo: Info? = nil


  // MARK: - ViewModel Methods
  /// Sets initial amount of characters(20)
  public func fetchCharacters() {
    Service.shared.execute(.listCharactersRequest,
                           expecting: GetAllCharactersResponse.self) { [weak self] result in
      switch result {
      case .success(let responseModel):
        let results = responseModel.results
        let info = responseModel.info
        self?.characters = results
        self?.apiInfo = info
        DispatchQueue.main.async {
          self?.delegate?.didLoadInitialCharacters()
        }
      case .failure(let error):
        print(String(describing: error))
      }
    }
  }

  /// Paginate if additional characters  are needed
  public func fetchAdditionalCharacters(url: URL) {
    guard !isLoadingMoreCharacters else { return }
    isLoadingMoreCharacters = true
    guard let request = Request(url: url) else { return }
    Service.shared.execute(request,
                           expecting: GetAllCharactersResponse.self) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let success):
        let additionalResults = success.results
        let info = success.info
        self.apiInfo = info
        let originalCount = self.characters.count
        let newCount = additionalResults.count
        let total = originalCount + newCount
        let startingIndex = total - newCount
        let indexPathToAdd: [IndexPath] = Array(startingIndex ..< (startingIndex + newCount)).compactMap {
          return IndexPath(row: $0, section: 0)
        }
        self.characters.append(contentsOf: additionalResults)
        DispatchQueue.main.async {
          self.delegate?.didLoadMoreCharacters(with: indexPathToAdd)
          self.isLoadingMoreCharacters = false
        }
      case .failure(let failure):
        print(String(describing: failure))
        self.isLoadingMoreCharacters = false
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier,
                                                        for: indexPath) as? CharacterCollectionViewCell else {
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
    let character = characters[indexPath.row]
    delegate?.didSelectCharacter(character)
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
    return CGSize(width: width, height: width * 1.5)
  }
}

// MARK: - ScrollViewDelegate Protocol Extension
extension EpisodeListViewViewModel: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldShowLoadMoreIndicator,
          !isLoadingMoreCharacters,
          !cellViewModels.isEmpty,
          let nexURLString = apiInfo?.next,
          let url = URL(string: nexURLString) else { return }
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
      let offset = scrollView.contentOffset.y
      let totalContentHeight = scrollView.contentSize.height
      let totalScrollViewFixedHeight = scrollView.frame.size.height
      if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
        self?.fetchAdditionalCharacters(url: url)
      }
      timer.invalidate()
    }
  }
}

