//
//  CharacterPhotoCollectionViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import Foundation

final class CharacterPhotoCollectionViewCellViewModel {

  // MARK: - Properties
  public let imageURL: URL?

  // MARK: - Init
  init(imageURL: URL?) {
    self.imageURL = imageURL
  }

  // MARK: - Meethods
  public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
    guard let imageURL = imageURL else {
      completion(.failure(URLError(.badURL)))
      return
    }
    ImageLoader.shared.downloadImage(imageURL, completion: completion)
  }
}
