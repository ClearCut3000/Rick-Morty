//
//  LocationViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import UIKit

final class LocationViewController: UIViewController {

  // MARK: - Properties
  private let primaryView = LocationView()
  private let viewModel = LocationViewViewModel()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(primaryView)
    view.backgroundColor = .systemBackground
    title = "Locations"
    addSearchButtton()
    addConstraints()
    viewModel.delegate = self
    viewModel.fetchLocations()
  }

  // MARK: - Methods
  private func addSearchButtton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                        target: self,
                                                        action: #selector(didTapSearch))
  }

  @objc private func didTapSearch() {

  }

  private func addConstraints() {
    NSLayoutConstraint.activate([
      primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
}

// MARK: - LocationViewViewModelDelegate Extension
extension LocationViewController: LocationViewViewModelDelegate {
  func didFetchInitialLocation() {
    primaryView.configure(with: viewModel)
  }
}
