//
//  CharacterDetailViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 17.05.2023.
//

import Foundation

final class CharacterDetailViewViewModel {

  // MARK: - Properties
  private let character: Character
  public var title: String {
    character.name.uppercased()
  }
  private var requestURL: URL? {
    return URL(string: character.url)
  }

  //MARK: - Init
  init(character: Character) {
    self.character = character
  }
}
