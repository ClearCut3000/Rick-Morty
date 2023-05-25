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

  public func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {

  }

  private func setupConstraints() {
    
  }
}
