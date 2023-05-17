//
//  CharacterDetailViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 17.05.2023.
//

import UIKit

/// COntroller to show info about single character
final class CharacterDetailViewController: UIViewController {

  // MARK: - Properties
  private let viewModel: CharacterDetailViewViewModel

  // MARK: - Init's
  init(viewModel: CharacterDetailViewViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has  not been implemented")
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = viewModel.title
  }
}
