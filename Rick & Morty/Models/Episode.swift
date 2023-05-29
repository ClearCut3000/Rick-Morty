//
//  Episode.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import Foundation

struct Episode: Codable, EpisodeDataRender {
  let id: Int
  let name: String
  let air_date: String
  let episode: String
  let characters: [String]
  let url: String
  let created: String
}
