//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import UIKit

protocol EpisodeDataRender {
  var name: String { get }
  var air_date: String { get }
  var episode: String { get }
}

final class CharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {

  // MARK: - Properties
  public let episodeDataURL: URL?
  private var isFetching = false
  private var episode: Episode? {
    didSet {
      guard let model = episode else { return }
      dataBlock?(model)
    }
  }
  private var dataBlock: ((EpisodeDataRender) -> Void)?
  public let borderColor: UIColor

  // MARK: - Init
  init(episodeDataURL: URL?, borderColor: UIColor = .systemBlue) {
    self.episodeDataURL = episodeDataURL
    self.borderColor = borderColor
  }

  // MARK: - Methods
  public func registedForData(_ block: @escaping (EpisodeDataRender) -> Void ) {

  }
  public func fetchEpisode() {
    guard !isFetching else {
      if let model = episode { dataBlock?(model) }
      return
    }
    guard let url = episodeDataURL,
          let request = Request(url: url) else { return }
    isFetching = true
    Service.shared.execute(request,
                           expecting: Episode.self) { [weak self] result in
      switch result {
      case .success(let success):
        DispatchQueue.main.async {
          self?.episode = success
        }
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }

  static func == (lhs: CharacterEpisodeCollectionViewCellViewModel, rhs: CharacterEpisodeCollectionViewCellViewModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.episodeDataURL?.absoluteString ?? "")
  }
}
