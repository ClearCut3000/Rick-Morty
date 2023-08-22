//
//  Endpoint.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.05.2023.
//

import Foundation

/// Represents unique API endpoints
@frozen enum Endpoint: String, CaseIterable, Hashable {
  case character
  case location
  case episode
}
