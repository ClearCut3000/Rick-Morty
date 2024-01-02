//
//  SearchInputViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 09.09.2023.
//

import Foundation

final class SearchInputViewViewModel {

  // MARK: - Properties
  private let type: SearchViewController.Config.SearchType
  enum DynamicOptions: String {
    case status = "Status"
    case gender = "Geender"
    case locationType = "Location Type"

    var queryArguments: String {
      switch self {
      case .status:
        return "status"
      case .gender:
        return "gender"
      case .locationType:
        return "type"
      }
    }

    var choises: [String] {
      switch self {
      case .status:
        return ["alive", "dead", "unknown"]
      case .gender:
        return ["male", "female", "genderless", "unknown"]
      case .locationType:
        return ["cluster", "planet", "space station", "microverse"]
      }
    }
  }
  public var hasDynamicOptions: Bool {
    switch self.type {
    case .character, .location:
      return true
    case .episode:
      return false
    }
  }
  public var options: [DynamicOptions] {
    switch self.type {
    case .character:
      return [.status, .gender]
    case .episode:
      return []
    case .location:
      return [.locationType]
    }
  }
  public var searchPlaceholderText: String {
    switch self.type {
    case .character:
      return "Charcter Name"
    case .episode:
      return "Episode Title"
    case .location:
      return "Location Name"
    }
  }

  // MARK: - Init
  init(type: SearchViewController.Config.SearchType) {
    self.type = type
  }

  //MARK: - Methods
  
}
