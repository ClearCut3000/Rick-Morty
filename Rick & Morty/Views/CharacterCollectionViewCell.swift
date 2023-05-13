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
  private let viewModel = CharacterCollectionViewCellViewModel()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func setupConstraints() {

  }

  override func prepareForReuse() {
    super.prepareForReuse()
  }

  public func configure(with viewModel: CharacterCollectionViewCellViewModel) {

  }
}
