//
//  CharacterInfoCollectionViewCell.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import UIKit

class CharacterInfoCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties
  static let identifier = "CharacterInfoCollectionViewCell"

  // MARK: - Subview's
  private let valueLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Earth"
    label.font = .systemFont(ofSize: 20, weight: .light)
    return label
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Location"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 22, weight: .medium)
    return label
  }()

  private let iconImageView: UIImageView = {
    let iconView = UIImageView()
    iconView.translatesAutoresizingMaskIntoConstraints = false
    iconView.image = UIImage(systemName: "globe")
    iconView.contentMode = .scaleAspectFit
    return iconView
  }()

  private var titleContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .secondarySystemBackground
    return view
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .tertiarySystemBackground
    contentView.layer.cornerRadius = 8
    contentView.addSubviews(titleContainerView, valueLabel, iconImageView)
    contentView.layer.masksToBounds = true
    titleContainerView.addSubview(titleLabel)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    valueLabel.text = nil
    titleLabel.text = nil
    titleLabel.tintColor = .label
    iconImageView.image = nil
    iconImageView.tintColor = .label
  }

  public func configure(with viewModel: CharacterInfoCollectionViewCellViewModel) {
    titleLabel.text = viewModel.title
    titleLabel.tintColor = viewModel.tintColor
    valueLabel.text = viewModel.displayValue
    iconImageView.image = viewModel.iconImage
    iconImageView.tintColor = viewModel.tintColor

  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),

      titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
      titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
      titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),

      iconImageView.heightAnchor.constraint(equalToConstant: 28),
      iconImageView.widthAnchor.constraint(equalToConstant: 28),
      iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
      iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

      valueLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
      valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
      valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor)
    ])
  }
}
