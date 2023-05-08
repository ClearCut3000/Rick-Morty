//
//  CharacterViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import UIKit

final class CharacterViewController: UIViewController {

  private let characterListView = CharacterListView()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Characters"
    NSLayoutConstraint.activate([
      characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
