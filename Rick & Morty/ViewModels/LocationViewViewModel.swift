//
//  LocationViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 26.08.2023.
//

import Foundation

final class LocationViewViewModel {

  // MARK: - Properties
  private var locations: [Location] = []
  private var cellViewModels: [String] = []
  private var hasMoreResults: Bool {
    return false
  }

  // MARK: - Init
  init() {

  }

  // MARK: - Methods
  public func fetchLocations() {
    Service.shared.execute(.listLocationsRequest, expecting: String.self) { result in
      switch result {
      case .success(let success):
        break
      case .failure(let failure):
        break
      }
    }
  }
}
