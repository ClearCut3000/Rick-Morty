//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import Foundation

final class CharacterEpisodeCollectionViewCellViewModel {

  // MARK: - Properties
  public let episodeDataURL: URL?

  // MARK: - Init
  init(episodeDataURL: URL?) {
    self.episodeDataURL = episodeDataURL
  }
}
