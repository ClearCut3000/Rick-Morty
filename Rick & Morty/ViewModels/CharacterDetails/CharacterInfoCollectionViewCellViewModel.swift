//
//  CharacterInfoCollectionViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import Foundation

final class CharacterInfoCollectionViewCellViewModel {

  // MARK: - Properties
  private let infoType: InfoType
  public let value: String
  public var title: String {
    self.infoType.displayTitle
  }

  enum InfoType {
    case status
    case gender
    case type
    case species
    case origin
    case created
    case location
    case episodeCount

    var displayTitle: String {
      switch self {
      case .status:
        <#code#>
      case .gender:
        <#code#>
      case .type:
        <#code#>
      case .species:
        <#code#>
      case .origin:
        <#code#>
      case .created:
        <#code#>
      case .location:
        <#code#>
      case .episodeCount:
        <#code#>
      }
    }
  }

  // MARK: - Init
  init(infoType: InfoType, value: String) {
    self.infoType = infoType
    self.value = value
  }
}
