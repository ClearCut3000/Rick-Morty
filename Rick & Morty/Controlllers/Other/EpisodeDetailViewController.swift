//
//  EpisodeDetailViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 13.06.2023.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {

  // MARK: - Properties
  private let viewModel: EpisodeDetailViewViewModel

  // MARK: - Init's
  init(url: URL?) {
    self.viewModel = .init(endpointURL: url)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

}
