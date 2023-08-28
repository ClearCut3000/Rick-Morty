//
//  LocationViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 26.08.2023.
//

import Foundation

protocol LocationViewViewModelDelegate: AnyObject {
  func didFetchInitialLocation()
}

final class LocationViewViewModel {

  // MARK: - Properties
  private var locations: [Location] = []
  private var apiInfo: GetAllLocationsResponse.Info?
  private var cellViewModels: [String] = []
  private var hasMoreResults: Bool {
    return false
  }
  weak var delegate: LocationViewViewModelDelegate?

  // MARK: - Init
  init() {

  }

  // MARK: - Methods
  public func fetchLocations() {
    Service.shared.execute(.listLocationsRequest,
                           expecting: GetAllLocationsResponse.self) { [weak self] result in
      switch result {
      case .success(let success):
        self?.apiInfo = success.info
        self?.locations = success.results
        DispatchQueue.main.async {
          self?.delegate?.didFetchInitialLocation()
        }
      case .failure(let failure):
        break
      }
    }
  }
}
