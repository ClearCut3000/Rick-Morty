//
//  SettingsCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.07.2023.
//

import UIKit

struct SettingsCellViewModel: Identifiable, Hashable {

  // MARK: - Properties
  let id = UUID()

  private let type: SettingsOption

  public var image: UIImage? {
    return type.iconImage
  }

  public var title: String {
    return type.displayTitle
  }

  public var iconContainerCollor: UIColor {
    return type.iconContainerCollor
  }

  // MARK: - Init
  init(type: SettingsOption) {
    self.type = type
  }
}
