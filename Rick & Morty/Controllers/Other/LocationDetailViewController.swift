//
//  LocationDetailViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 07.09.2023.
//

import UIKit

final class LocationDetailViewController: UIViewController {

  // MARK: - Properties
  private let viewModel: LocationDetailViewViewModel

  private let detailView = LocationDetailView()

  // MARK: - Init's
  init(location: Location) {
    let url = URL(string: location.url)
    self.viewModel = LocationDetailViewViewModel(endpointURL: url)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(detailView)
    detailView.delegate = self
    viewModel.delegate = self
    addConstraints()
    title = "Location"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    viewModel.fetchLocationData()
  }

  // MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }

  private func addSearchButton() {

  }

  @objc private func didTapShare() {
    let viewController = SearchViewController(config: .init(type: .location))
    viewController.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - LocationDetailViewViewModelDelegate Extension
extension LocationDetailViewController: LocationDetailViewViewModelDelegate {
  func didFetchLocationDetails() {
    detailView.configure(with: viewModel)
  }
}

// MARK: - LocationDetailViewDelegate Protocol Extension
extension LocationDetailViewController: LocationDetailViewDelegate {
  func episodeDetailViewDelegate(_ detailView: LocationDetailView, didSelect character: Character) {
    let viewController = CharacterDetailViewController(viewModel: .init(character: character))
    viewController.title = character.name
    viewController.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(viewController, animated: true)
  }
}
