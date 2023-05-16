//
//  CharacterStatus.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 04.05.2023.
//

import Foundation

enum CharacterStatus: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown = "unknown"

  var text: String {
    switch self {
    case .alive, .dead:
      return rawValue
    case .unknown:
      return "Unknown"
    }
  }
}
