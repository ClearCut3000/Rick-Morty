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
    characterListView.delegate = self
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

// MARK: - CharacterListViewDelegate Protocol Extension
extension CharacterViewController: CharacterListViewDelegate {
  func rmCharacterListView(_ characterListView: CharacterListView, didSelectCharacter character: Character) {
    let viewModel = CharacterDetailViewViewModel(character: character)
    let detailViewController = CharacterDetailViewController(viewModel:  viewModel)
    detailViewController.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
