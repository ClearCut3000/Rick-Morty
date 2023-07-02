//
//  SettingsCellViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.07.2023.
//

import UIKit

struct SettingsCellViewModel {

  public var image: UIImage? {
    return type.iconImage
  }
  public var title: String {
    return type.displayTitle
  }
  private let type: SettingsOption

  init(type: SettingsOption) {
    self.type = type
  }
}
