//
//  EpisodeDetailView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 14.06.2023.
//

import UIKit

final class EpisodeDetailView: UIView {

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
