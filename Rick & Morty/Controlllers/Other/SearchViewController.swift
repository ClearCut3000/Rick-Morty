//
//  SearchViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 21.06.2023.
//

import UIKit

/// Configurable controller for search
final class SearchViewController: UIViewController {

  // MARK: - Properties
  struct Config {
    enum SearchType {
      case character
      case episode
      case location
    }
    let type: SearchType
  }
  private let config: Config

  // MARK: - Init's
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    view.backgroundColor = .systemBackground
  }
  
}
