//
//  SettingsViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import UIKit

final class SettingsViewController: UIViewController {

  // MARK: - Properties
  private let viewModel = SettingsViewViewModel(cellViewModel: SettingsOption.allCases.compactMap({
    return SettingsCellViewModel(type: $0)
  }))

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Settings"
  }
}
