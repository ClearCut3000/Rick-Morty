//
//  GetAllCharactersResponse.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 08.05.2023.
//

import Foundation

struct GetAllCharactersResponse: Codable {
  
  struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
  }
  
  let info: Info
  let results: [Character]
}

