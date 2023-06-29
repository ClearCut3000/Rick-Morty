//
//  EpisodeInfoCollectionViewCell.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.06.2023.
//

import UIKit

final class EpisodeInfoCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties
  static let identifier = "EpisodeInfoCollectionViewCell"

  // MARK: - Subview's
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let valueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.textAlignment = .right
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
    contentView.addSubviews(titleLabel, valueLabel)
    setupLayer()
    addConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    valueLabel.text = nil
  }

  private func setupLayer() {
    layer.cornerRadius = 8
    layer.masksToBounds = true
    layer.borderWidth = 1
    layer.borderColor = UIColor.secondaryLabel.cgColor
  }

  private func addConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

      valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
      valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),

      titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
      valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47)
    ])
  }

  func configure(with viewModel: EpisodeInfoCollectionViewCellViewModel) {
    titleLabel.text = viewModel.title
    valueLabel.text = viewModel.value
  }
}
