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
  private let detailView: CharacterDetailView

  // MARK: - Init's
  init(viewModel: CharacterDetailViewViewModel) {
    self.viewModel = viewModel
    self.detailView = CharacterDetailView(frame: .zero, viewModel: viewModel)
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
    view.addSubview(detailView)
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                        target: self,
                                                        action: #selector(didTapShare))
    addConstraints()
    detailView.collectionView?.dataSource = self
    detailView.collectionView?.delegate = self 
  }

  // MARK: - Meethods
  func addConstraints() {
    NSLayoutConstraint.activate([
     detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
     detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
     detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
     detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  @objc private func didTapShare() {
    
  }
}

// MARK: - UICollectionViewDelegate Protocol Extension
extension CharacterDetailViewController: UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.sections.count
  }
}

// MARK: - UICollectionViewDataSource Protocol Extension
extension CharacterDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
    cell.backgroundColor = .systemGray
    return cell
  }
}
