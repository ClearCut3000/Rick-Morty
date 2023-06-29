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

  private let detailView = EpisodeDetailView()

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
    view.addSubview(detailView)
    detailView.delegate = self
    viewModel.delegate = self
    addConstraints()
    title = "Episode"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    viewModel.fetchEpisodeData()
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

  private func addSeearchButton() {
    
  }

  @objc private func didTapShare() {

  }
}

// MARK: - EpisodeDetailViewViewModelDelegate Extension
extension EpisodeDetailViewController: EpisodeDetailViewViewModelDelegate {
  func didFetchEpisodeDetails() {
    detailView.configure(with: viewModel)
  }
}

// MARK: - EpisodeDetailViewDelegate Protocol Extension
extension EpisodeDetailViewController: EpisodeDetailViewDelegate {
  func episodeDetailViewDelegate(_ detailView: EpisodeDetailView, didSelect character: Character) {
    let viewController = CharacterDetailViewController(viewModel: .init(character: character))
    viewController.title = character.name
    viewController.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(viewController, animated: true)
  }
}
