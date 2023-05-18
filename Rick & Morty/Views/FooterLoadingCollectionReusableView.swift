//
//  FooterLoadingCollectionReusableView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 18.05.2023.
//

import UIKit

final class FooterLoadingCollectionReusableView: UICollectionReusableView {

  // MARK: - Properties
  static let identtifier = "FooterLoadingCollectionReusableView"

  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.hidesWhenStopped = true
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    addSubview(spinner)
    addConstraints()
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

  public func startAnimating() {
    spinner.startAnimating()
  }
}
