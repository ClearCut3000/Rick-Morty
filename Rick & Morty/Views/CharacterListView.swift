//
//  CharacterListView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 08.05.2023.
//

import UIKit

/// View that handles list of characters, loader, etc.
final class CharacterListView: UIView {

  // MARK: - Properties
  private let viewModel = CharacterListViewViewModel()
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(spinner)
    addConstraints()
    spinner.startAnimating()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      spinner.widthAnchor.constraint(equalToConstant: 100),
      spinner.heightAnchor.constraint(equalToConstant: 100),
      spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

}
