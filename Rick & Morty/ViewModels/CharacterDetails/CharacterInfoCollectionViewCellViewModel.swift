//
//  CharacterInfoCollectionViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import Foundation

final class CharacterInfoCollectionViewCellViewModel {

  // MARK: - Properties
  public var value: String
  public var title: String

  // MARK: - Init
  init(value: String, title: String) {
    self.value = value
    self.title = title
  }
}
