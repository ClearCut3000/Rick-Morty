//
//  LocationTableViewCell.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 06.09.2023.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {

  // MARK: - Properties
  static let identifier = "LocationTableViewCell"

  // MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .systemBackground
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Meethods
  override func prepareForReuse() {
    super.prepareForReuse()
  }

  public func configure(with viewModel: LocationTableViewCellViewModel) {

  }
}
