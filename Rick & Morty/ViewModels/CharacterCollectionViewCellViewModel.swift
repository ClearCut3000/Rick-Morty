//
//  CharacterCollectionViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 13.05.2023.
//

import Foundation

final class CharacterCollectionViewCellViewModel: Hashable, Equatable {
  // MARK: - Properties
  public let characterName: String
  private let characterStatus: CharacterStatus
  private let characterImageURL: URL?
  public var characterStatusText: String {
    return "Status: \(characterStatus.text)"
  }

  // MARK: - Init
  init(characterName: String,
       characterStatus: CharacterStatus,
       characterImageURL: URL?) {
    self.characterName = characterName
    self.characterStatus = characterStatus
    self.characterImageURL = characterImageURL
  }

  // MARK: - Methods
  static func == (lhs: CharacterCollectionViewCellViewModel, rhs: CharacterCollectionViewCellViewModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }

  public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
    guard let url = characterImageURL else {
      completion(.failure(URLError(.badURL)))
      return
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(error ?? URLError(.badServerResponse)))
        return
      }
      completion(.success(data))
    }
    task.resume()
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(characterName)
    hasher.combine(characterStatus)
    hasher.combine(characterImageURL)
  }
}
