//
//  SearchViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 09.09.2023.
//

import Foundation

final class SearchViewViewModel {

  // MARK: - Properties
  let config: SearchViewController.Config
  private var optionMap: [SearchInputViewViewModel.DynamicOptions: String] = [:]
  private var optionMapUpdateBlock: (((SearchInputViewViewModel.DynamicOptions, String)) -> Void)?
  private var searchText = ""
  private var searchResultBlock: ((SearchResultViewModel) -> Void)?

  // MARK: - Init
  init(config: SearchViewController.Config) {
    self.config = config
  }

  // MARK: - Methods
  public func executeSearch() {
    /// Build arguments
    var queryParameters: [URLQueryItem] =  [URLQueryItem(name: "name",
                                                         value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]

    /// Add options
    queryParameters.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
      let key: SearchInputViewViewModel.DynamicOptions = element.key
      let value: String = element.value
      return URLQueryItem(name: key.queryArguments, value: value)
    }))

    /// Send API call by creating request
    let request = Request(endpoint: config.type.endpoint,
                          queryParameters: queryParameters)

    switch config.type.endpoint {
    case .character:
      makeSearchAPICall(GetAllCharactersResponse.self, request: request)
    case .episode:
      makeSearchAPICall(GetAllEpisodesResponse.self, request: request)
    case .location:
      makeSearchAPICall(GetAllLocationsResponse.self, request: request)
    }


    /// Notify view

  }

  public func registerSearchResultBlock(_ block: @escaping ((SearchResultViewModel) -> Void)) {
    self.searchResultBlock = block
  }

  public func set(query text: String) {
    self.searchText = text
  }

  public func set(value: String, for option: SearchInputViewViewModel.DynamicOptions) {
    optionMap[option] = value
    let tuple = (option, value)
    optionMapUpdateBlock?(tuple)
  }

  public func registerOptionChangeBlock(_ block: @escaping ((SearchInputViewViewModel.DynamicOptions, String)) -> Void) {
    self.optionMapUpdateBlock = block
  }

  private func processSearchResults(_ model: Codable) {
    var resultsViewModel: SearchResultViewModel?
    if let charactersResult = model as? GetAllCharactersResponse {
      resultsViewModel = .characters(charactersResult.results.compactMap({
        return CharacterCollectionViewCellViewModel(characterName: $0.name,
                                                    characterStatus: $0.status,
                                                    characterImageURL: URL(string: $0.image))
      }))
    } else if let episodesResult = model as? GetAllEpisodesResponse {
      resultsViewModel = .episodes(episodesResult.results.compactMap ({
        return CharacterEpisodeCollectionViewCellViewModel(episodeDataURL: URL(string: $0.url))
      }))
    } else if let locationsResult = model as? GetAllLocationsResponse {
      resultsViewModel = .locations(locationsResult.results.compactMap({
        return LocationTableViewCellViewModel(with: $0)
      }))
    }
    if let results = resultsViewModel {
      self.searchResultBlock?(results)
    } else {
      //Error
    }
  }

  private func makeSearchAPICall<T: Codable>(_ type: T.Type, request: Request) {
    Service.shared.execute(request,
                           expecting: type) { [weak self] result in
      switch result {
      case .success(let model):
        self?.processSearchResults(model)
      case .failure(let error):
        break
      }
    }
  }
}
