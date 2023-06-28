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
    contentView.backgroundColor = .secondarySystemBackground
    setupLayer()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
  }

  private func setupLayer() {
    layer.cornerRadius = 8
    layer.masksToBounds = true
    layer.borderWidth = 1
    layer.borderColor = UIColor.secondaryLabel.cgColor
  }

  func configure(with viewModel: EpisodeInfoCollectionViewCellViewModel) {

  }
}
