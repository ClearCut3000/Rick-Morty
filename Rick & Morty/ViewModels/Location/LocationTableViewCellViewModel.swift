//
//  LocationTableViewCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 06.09.2023.
//

import Foundation

struct LocationTableViewCellViewModel: Hashable, Equatable {

  private let location: Location

  init(with location: Location) {
    self.location = location
  }

  public var name: String {
    return location.name
  }

  public var type: String {
    return location.type
  }

  public var dimension: String {
    return location.dimension
  }

  static func == (lhs: LocationTableViewCellViewModel, rhs: LocationTableViewCellViewModel) -> Bool {
    return lhs.location.id == rhs.location.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(location.id)
    hasher.combine(dimension)
    hasher.combine(type)
  }
}

