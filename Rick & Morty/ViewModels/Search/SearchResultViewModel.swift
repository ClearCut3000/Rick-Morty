//
//  SearchResultViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 05.01.2024.
//

import Foundation

enum SearchResultViewModel {
  case characters([CharacterCollectionViewCellViewModel])
  case episodes([CharacterEpisodeCollectionViewCellViewModel])
  case locations([LocationTableViewCellViewModel])
}
