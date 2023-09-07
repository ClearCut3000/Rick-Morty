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
  private var locations: [Location] = [] {
    didSet {
      for location in locations {
        let cellViewModel = LocationTableViewCellViewModel(with: location)
        if !cellViewModels.contains(cellViewModel) {
          cellViewModels.append(cellViewModel)
        }
      }
    }
  }
  private var apiInfo: GetAllLocationsResponse.Info?
  public private(set) var cellViewModels: [LocationTableViewCellViewModel] = []
  private var hasMoreResults: Bool {
    return false
  }
  weak var delegate: LocationViewViewModelDelegate?

  // MARK: - Init
  init() {}

  // MARK: - Methods
  public func location(at index: Int) -> Location? {
    guard index < locations.count, index >= 0 else {
      return nil
    }
    return self.locations[index]
  }
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
