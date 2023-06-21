//
//  LocationViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import UIKit

final class LocationViewController: UIViewController {

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Locations"
    addSearchButtton()
  }

  // MARK: - Methods
  private func addSearchButtton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                        target: self,
                                                        action: #selector(didTapSearch))
  }

  @objc private func didTapSearch() {

  }
}
