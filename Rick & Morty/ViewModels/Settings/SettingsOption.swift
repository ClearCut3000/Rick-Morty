//
//  SettingsOption.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.07.2023.
//

import UIKit

enum SettingsOption: CaseIterable {
  case rateApp
  case contactUs
  case terms
  case privacy
  case apiReference
  case viewSeries
  case viewCode

  var targetURL: URL? {
    switch self {
    case .rateApp:
      return nil
    case .contactUs:
      return URL(string: "https://github.com/ClearCut3000")
    case .terms:
      return URL(string: "https://github.com/ClearCut3000")
    case .privacy:
      return URL(string: "https://github.com/ClearCut3000")
    case .apiReference:
      return URL(string: "https://rickandmortyapi.com/documentation")
    case .viewSeries:
      return URL(string: "https://www.youtube.com/watch?v=fTGA8cjbf5Y")
    case .viewCode:
      return URL(string: "https://github.com/ClearCut3000/Rick-Morty")
    }
  }

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

  var iconContainerCollor: UIColor {
    switch self {
    case .rateApp:
      return .systemRed
    case .contactUs:
      return .systemBlue
    case .terms:
      return .systemCyan
    case .privacy:
      return .systemMint
    case .apiReference:
      return .systemPink
    case .viewSeries:
      return .systemBrown
    case .viewCode:
      return .systemOrange
    }
  }

  var iconImage: UIImage? {
    switch self {
    case .rateApp:
      return UIImage(systemName: "star.fill")
    case .contactUs:
      return UIImage(systemName: "paperplane")
    case .terms:
      return UIImage(systemName: "doc")
    case .privacy:
      return UIImage(systemName: "lock")
    case .apiReference:
      return UIImage(systemName: "list.clipboard")
    case .viewSeries:
      return UIImage(systemName: "tv.fill")
    case .viewCode:
      return UIImage(systemName: "hammer")
    }
  }
}
