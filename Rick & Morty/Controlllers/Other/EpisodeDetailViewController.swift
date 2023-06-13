//
//  EpisodeDetailViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 13.06.2023.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {

  // MARK: - Properties
  private let url: URL?

  // MARK: - Init's
  init(url: URL?) {
    self.url = url
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
