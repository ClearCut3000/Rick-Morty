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
  /// Configuration for search session
  struct Config {
    enum SearchType {
      case character
      case episode
      case location

      var title: String {
        switch self {
        case .character:
          return "Search Characters"
        case .episode:
          return "Search Episode"
        case .location:
          return "Search Location"
        }
      }
    }
    let type: SearchType
  }
  private let viewModel: SearchViewViewModel
  private let searchView: SearchView

  // MARK: - Init's
  init(config: Config) {
    let viewModel = SearchViewViewModel(config: config)
    self.viewModel = viewModel
    self.searchView = SearchView(frame: .zero, viewModel: viewModel)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = viewModel.config.type.title
    view.backgroundColor = .systemBackground
    view.addSubview(searchView)
    addConstraints()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", 
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(didTapExecuteSearch))
    searchView.delegate = self
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    searchView.presentKeeyboard()
  }

  // MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
     searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
     searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
     searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }


  @objc private func didTapExecuteSearch() {
    viewModel.executeSearch()
  }
}

// MARK: Extension
extension SearchViewController: SearchViewDelegate {
  func searchView(_ searchView: SearchView, didSelectOption option: SearchInputViewViewModel.DynamicOptions) {
    let viewController = SearchOptionPickerViewController(option: option) { [weak self] selection in
      DispatchQueue.main.async {
        self?.viewModel.set(value: selection, for: option)
      }
    }
    viewController.sheetPresentationController?.detents = [.medium()]
    viewController.sheetPresentationController?.prefersGrabberVisible = true
    present(viewController, animated: true)
  }
}
