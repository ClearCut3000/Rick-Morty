//
//  EpisodeDetailViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 14.06.2023.
//

import Foundation

class EpisodeDetailViewViewModel {

  // MARK: - Properties
  private let endpointURL: URL?

  // MARK: - Init
  init(endpointURL: URL?) {
    self.endpointURL = endpointURL
    fetchEpisodeData()
  }

  // MARK: - Methods
  private func fetchEpisodeData() {
    guard let url = endpointURL,
          let request = Request(url: url) else { return }
    Service.shared.execute(request,
                           expecting: Episode.self) { result in
      switch result {
      case .success(let success):
        print(String(describing: success))
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }
}
