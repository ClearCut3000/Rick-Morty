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
  private var searchResultBlock: (() -> Void)?

  // MARK: - Init
  init(config: SearchViewController.Config) {
    self.config = config
  }

  // MARK: - Methods
  public func executeSearch() {
    /// Build arguments
    var queryParameters: [URLQueryItem] =  [URLQueryItem(name: "name", value: searchText)]

    /// Add options
    queryParameters.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
      let key: SearchInputViewViewModel.DynamicOptions = element.key
      let value: String = element.value
      return URLQueryItem(name: key.queryArguments, value: value)
    }))

    /// Send API call by creating request
    let request = Request(endpoint: config.type.endpoint,
                          queryParameters: queryParameters)

    Service.shared.execute(request,
                           expecting: String.self) { result in
      switch result {
      case .success(let model):
        print("Success: \(model)")
      case .failure(let error):
        break
      }
    }

    /// Notify view
  }

  public func registerSearchResultBlock(_ block: @escaping (() -> Void)) {
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
}
