//
//  EpisodeDetailViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 14.06.2023.
//

import Foundation

protocol EpisodeDetailViewViewModelDelegate: AnyObject {
  func didFetchEpisodeDetails()
}

final class EpisodeDetailViewViewModel {

  // MARK: - Properties
  private let endpointURL: URL?

  public weak var delegate: EpisodeDetailViewViewModelDelegate?
  
  private var dataTuple: (Episode, [Character])? {
    didSet {
      delegate?.didFetchEpisodeDetails()
    }
  }

  // MARK: - Init
  init(endpointURL: URL?) {
    self.endpointURL = endpointURL
  }

  // MARK: - Methods
  public func fetchEpisodeData() {
    guard let url = endpointURL,
          let request = Request(url: url) else { return }
    Service.shared.execute(request,
                           expecting: Episode.self) { [weak self] result in
      switch result {
      case .success(let success):
        self?.fetchRelatedCharacters(episode: success)
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }

  private func fetchRelatedCharacters(episode: Episode) {
    let requests = episode.characters.compactMap {
      return URL(string: $0)
    }.compactMap {
      return Request(url: $0)
    }
    let group = DispatchGroup()
    var characters: [Character] = []
    for request in requests {
      group.enter()
      Service.shared.execute(request,
                             expecting: Character.self) { result in
        defer {
          group.leave()
        }
        switch result {
        case .success(let success):
          characters.append(success)
        case .failure(let failure):
          print(String(describing: failure))
        }
      }
    }
    group.notify(queue: .main) {
      self.dataTuple = (  episode, characters )
    }
  }
} 
