//
//  SettingsCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.07.2023.
//

import UIKit

struct SettingsCellViewModel: Identifiable {

  // MARK: - Properties
  let id = UUID()

  public let type: SettingsOption
  public let onTapHandler: (SettingsOption) -> Void

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
  init(type: SettingsOption, onTapHandler: @escaping (SettingsOption) -> Void) {
    self.type = type
    self.onTapHandler = onTapHandler
  }
}
