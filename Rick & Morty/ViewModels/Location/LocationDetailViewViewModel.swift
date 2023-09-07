//
//  LocationDetailViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 07.09.2023.
//

import Foundation

protocol LocationDetailViewViewModelDelegate: AnyObject {
  func didFetchLocationDetails()
}

final class LocationDetailViewViewModel {

  // MARK: - Properties
  public weak var delegate: LocationDetailViewViewModelDelegate?

  public private(set) var cellViewModels: [SectionType] = []

  private let endpointURL: URL?

  private var dataTuple: (location: Location, characters: [Character])? {
    didSet {
      createCellViewModels()
      delegate?.didFetchLocationDetails()
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
  public func fetchLocationData() {
    guard let url = endpointURL,
          let request = Request(url: url) else { return }
    Service.shared.execute(request,
                           expecting: Location.self) { [weak self] result in
      switch result {
      case .success(let success):
        self?.fetchRelatedCharacters(location: success)
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }

  public func character(at index: Int) -> Character? {
    guard let dataTuple = dataTuple else {
      return nil
    }
    return dataTuple.characters[index]
  }

  private func fetchRelatedCharacters(location: Location) {
    let requests = location.residents.compactMap {
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
      self.dataTuple = (location: location, characters: characters)
    }
  }

  private func createCellViewModels() {
    guard let dataTuple else { return }
    let location = dataTuple.location
    let characters = dataTuple.characters
    var createdString = location.created
    if let createdDate = CharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
      createdString = CharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: createdDate)
    }
    cellViewModels = [
      .information(viewModel: [
        .init(title: "Location Name", value: location.name),
        .init(title: "Type", value: location.type),
        .init(title: "Dimension", value: location.dimension),
        .init(title: "Created", value: createdString)
      ]),
      .characters(viewModel: characters.compactMap({ character in
        return CharacterCollectionViewCellViewModel(characterName:character.name,
                                                    characterStatus: character.status,
                                                    characterImageURL: URL(string: character.image))
      }))
    ]
  }
}
