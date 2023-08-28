//
//  GetAllLocationsResponse.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 28.08.2023.
//

import Foundation

struct GetAllLocationsResponse: Codable {

  struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
  }

  let info: Info
  let results: [Location]
}
