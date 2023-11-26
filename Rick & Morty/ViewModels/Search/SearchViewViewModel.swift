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

  // MARK: - Init
  init(config: SearchViewController.Config) {
    self.config = config
  }

  // MARK: - Methods
  public func executeSearch() {
    
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
