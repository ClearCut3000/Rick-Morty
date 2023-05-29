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
    contentView.backgroundColor = .tertiarySystemBackground
    contentView.backgroundColor = .tertiarySystemBackground
    contentView.layer.cornerRadius = 8
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
    viewModel.registedForData { data in
      
    }
    viewModel.fetchEpisode()
  }

  private func setupConstraints() {
    
  }
}
