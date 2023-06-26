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

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
  }

  func configure(with viewModel: EpisodeInfoCollectionViewCellViewModel) {

  }
}
