//
//  SettingsOption.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.07.2023.
//

import UIKit

enum SettingsOption {
  case rateApp
  case contactUs
  case terms
  case privacy
  case apiReference
  case viewSeries
  case viewCode

  var displayTitle: String {
    switch self {
    case .rateApp:
      return "Rate App"
    case .contactUs:
      return "Contact Us"
    case .terms:
      return "Terms"
    case .privacy:
      return "Privacy"
    case .apiReference:
      return "API reference"
    case .viewSeries:
      return "View Video Series"
    case .viewCode:
      return "View App Code"
    }
  }

  var iconImage: UIImage? {
    switch self {
    case .rateApp:
      return UIImage(systemName: "")
    case .contactUs:
      return UIImage(systemName: "")
    case .terms:
      return UIImage(systemName: "")
    case .privacy:
      return UIImage(systemName: "")
    case .apiReference:
      return UIImage(systemName: "")
    case .viewSeries:
      return UIImage(systemName: "")
    case .viewCode:
      return UIImage(systemName: "")
    }
  }
}
