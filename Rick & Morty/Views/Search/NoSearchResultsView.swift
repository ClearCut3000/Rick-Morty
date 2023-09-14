//
//  NoSearchResultsView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 09.09.2023.
//

import UIKit

final class NoSearchResultsView: UIView {

  // MARK: - Properties
  private let viewModel = NoSearchResultsViewViewModel()

  // MARK: - Subview's
  private let iconView: UIImageView = {
    let iconView = UIImageView()
    iconView.translatesAutoresizingMaskIntoConstraints = false
    iconView.contentMode = .scaleAspectFit
    iconView.tintColor = .systemBlue
    return iconView
  }()

  private let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20, weight: .medium)
    return label
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    isHidden = true
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(iconView, label)
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      iconView.widthAnchor.constraint(equalToConstant: 90),
      iconView.heightAnchor.constraint(equalToConstant: 90),
      iconView.topAnchor.constraint(equalTo: topAnchor),
      iconView.centerXAnchor.constraint(equalTo: centerXAnchor),

      label.leftAnchor.constraint(equalTo: leftAnchor),
      label.rightAnchor.constraint(equalTo: rightAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
      label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10)
    ])
  }

  private func configure() {
    label.text = viewModel.title
    iconView.image = viewModel.image
  }
}
