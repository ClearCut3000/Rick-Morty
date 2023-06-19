//
//  GetAllEpisodesResponse.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 19.06.2023.
//

import Foundation

struct GetAllEpisodesResponse: Codable {

  struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
  }

  let info: Info
  let results: [Episode]
}
