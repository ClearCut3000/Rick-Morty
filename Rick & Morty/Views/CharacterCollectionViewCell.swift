//
//  CharacterCollectionViewCell.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 13.05.2023.
//

import UIKit

/// Single cell for Character
class CharacterCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  static let identifier = "CharacterCollectionViewCell"
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = .systemFont(ofSize: 18, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private let statusLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
    contentView.addSubviews(imageView, nameLabel, statusLabel)
    addConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func addConstraints() {
    NSLayoutConstraint.activate([
      statusLabel.heightAnchor.constraint(equalToConstant: 44),
      statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
      statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
      statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
      nameLabel.heightAnchor.constraint(equalToConstant: 44),
      nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
      nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
      nameLabel.bottomAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: -3),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
    ])
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    nameLabel.text = nil
    statusLabel.text = nil
  }

  public func configure(with viewModel: CharacterCollectionViewCellViewModel) {
    nameLabel.text = viewModel.characterName
    statusLabel.text = viewModel.characterStatusText
    viewModel.fetchImage { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          let image = UIImage(data: data)
          self?.imageView.image = image
        }
      case .failure(let error):
        break
      }
    }
  }
}
