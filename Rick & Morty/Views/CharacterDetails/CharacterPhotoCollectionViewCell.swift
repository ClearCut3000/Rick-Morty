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
  private let characterPhotoView: UIImageView = {
    let characterPhotoView = UIImageView()
    characterPhotoView.contentMode = .scaleAspectFill
    characterPhotoView.clipsToBounds = true
    characterPhotoView.translatesAutoresizingMaskIntoConstraints = false
    return characterPhotoView
  }()

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(characterPhotoView)
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
    viewModel.fetchImage { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.characterPhotoView.image = UIImage(data: data)
        }
      case .failure(_):
        break
      }
    }
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      characterPhotoView.topAnchor.constraint(equalTo: contentView.topAnchor),
      characterPhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      characterPhotoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      characterPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
