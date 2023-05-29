//
//  CharacterInfoCollectionViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import Foundation
import UIKit

final class CharacterInfoCollectionViewCellViewModel {

  // MARK: - Properties
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
    formatter.timeZone = .current
    return formatter
  }()
  static let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
  }()
  private let infoType: InfoType
  private let value: String
  public var title: String {
    infoType.displayTitle
  }
  public var displayValue: String {
    if value.isEmpty { return "None" }
    if let date = Self.dateFormatter.date(from: value),
       infoType == .created {
      return  Self.shortDateFormatter.string(from: date)
    }
    return value
  }

  public var iconImage: UIImage? {
    return infoType.iconImage
  }

  public var tintColor: UIColor {
    return infoType.tintColor
  }

  enum InfoType: String {
    case status
    case gender
    case type
    case species
    case origin
    case created
    case location
    case episodeCount

    var tintColor: UIColor {
      switch self {
      case .status:
        return .systemBlue
      case .gender:
        return .systemRed
      case .type:
        return .systemCyan
      case .species:
        return .systemMint
      case .origin:
        return .systemPink
      case .created:
        return .systemYellow
      case .location:
        return .systemOrange
      case .episodeCount:
        return .systemPurple
      }
    }

    var iconImage: UIImage? {
      switch self {
      case .status:
        return UIImage(systemName: "bell")
      case .gender:
        return UIImage(systemName: "bell")
      case .type:
        return UIImage(systemName: "bell")
      case .species:
        return UIImage(systemName: "bell")
      case .origin:
        return UIImage(systemName: "bell")
      case .created:
        return UIImage(systemName: "bell")
      case .location:
        return UIImage(systemName: "bell")
      case .episodeCount:
        return UIImage(systemName: "bell")
      }
    }

    var displayTitle: String {
      switch self {
      case .status, .gender, .type, .species, .origin, .created, .location:
        return rawValue.uppercased()
      case .episodeCount:
        return "Episode Count"
      }
    }
  }

  // MARK: - Init
  init(infoType: InfoType, value: String) {
    self.infoType = infoType
    self.value = value
  }
}
