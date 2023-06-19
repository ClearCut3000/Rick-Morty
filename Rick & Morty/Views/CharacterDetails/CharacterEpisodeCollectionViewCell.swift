//
//  CharacterEpisodeCollectionViewCell.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import UIKit

class CharacterEpisodeCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties
  static let identifier = "CharacterEpisodeCollectionViewCell"

  // MARK: - Subview's
  private let  seasonLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    return label
  }()

  private let  nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 22, weight: .regular)
    return label
  }()

  private let  airDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .light)
    return label
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayer()
    contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    seasonLabel.text = nil
    nameLabel.text = nil
    airDateLabel.text = nil
  }

  public func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {
    viewModel.registedForData { [weak self] data in
      self?.nameLabel.text = data.name
      self?.seasonLabel.text = "Episode " + data.episode
      self?.airDateLabel.text = "Aired on " + data.air_date
    }
    viewModel.fetchEpisode()
    contentView.layer.borderColor = viewModel.borderColor.cgColor
  }

  private func setupLayer() {
    contentView.backgroundColor = .tertiarySystemBackground
    contentView.layer.borderWidth = 2
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
      seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
      seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

      nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
      nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
      nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
      nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

      airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
      airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
      airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
    ])
  }
}
