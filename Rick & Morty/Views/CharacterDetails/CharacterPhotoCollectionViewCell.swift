//
//  CharacterPhotoCollectionViewCell.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 25.05.2023.
//

import UIKit

class CharacterPhotoCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties
  static let identifier = "CharacterPhotoCollectionViewCell"

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
  }

  public func configure(with viewModel: CharacterPhotoCollectionViewCellViewModel) {

  }

  private func setupConstraints() {

  }
}
