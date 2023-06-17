//
//  EpisodeViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import UIKit

class EpisodeViewController: UIViewController {
  private let episodeListView = EpisodeListView()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    episodeListView.delegate = self
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Episodes"
    NSLayoutConstraint.activate([
      episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - CharacterListViewDelegate Protocol Extension
extension EpisodeViewController: EpisodeListViewDelegate {
  func rmEpisodeListViewDelegate(_ episodeListView: EpisodeListView, didSelectEpisode episode: Episode) {
    let detailViewController = EpisodeDetailViewController(url: URL(string: episode.url))
    detailViewController.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

