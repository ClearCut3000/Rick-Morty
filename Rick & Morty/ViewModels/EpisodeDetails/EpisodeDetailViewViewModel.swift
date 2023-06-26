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
  public weak var delegate: EpisodeDetailViewViewModelDelegate?

  public private(set) var cellViewModels: [SectionType] = []

  private let endpointURL: URL?
  
  private var dataTuple: (episode: Episode, characters: [Character])? {
    didSet {
      createCellViewModels()
      delegate?.didFetchEpisodeDetails()
    }
  }

  enum SectionType {
    case information(viewModel: [EpisodeInfoCollectionViewCellViewModel])
    case characters(viewModel: [CharacterCollectionViewCellViewModel] )
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
      self.dataTuple = ( episode: episode, characters: characters )
    }
  }

  private func createCellViewModels() {
    guard let dataTuple else { return }
    let episode = dataTuple.episode
    let characters = dataTuple.characters
    cellViewModels = [
      .information(viewModel: [
        .init(title: "Episode Name", value: episode.name),
        .init(title: "Air Date", value: episode.air_date),
        .init(title: "Episode", value: episode.episode),
        .init(title: "Created", value: episode.created)
      ]),
      .characters(viewModel: characters.compactMap({ character in
        return CharacterCollectionViewCellViewModel(characterName:character.name,
                                                    characterStatus: character.status,
                                                    characterImageURL: URL(string: character.image))
      }))
    ]
  }
} 
