//
//  SettingsViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import SwiftUI
import UIKit

final class SettingsViewController: UIViewController {

  // MARK: - Properties
  private let settingsSUIView = UIHostingController(rootView:
                                                  SettingsView(viewModel:
                                                                          SettingsViewViewModel(cellViewModel:
                                                                                                  SettingsOption.allCases.compactMap({
    return SettingsCellViewModel(type: $0)
  }))))

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Settings"
    addSUIConttroller()
  }

  // MARK: - Methods
  private func addSUIConttroller() {
    addChild(settingsSUIView)
    settingsSUIView.didMove(toParent: self)
    view.addSubview(settingsSUIView.view)
    settingsSUIView.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      settingsSUIView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      settingsSUIView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      settingsSUIView.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      settingsSUIView.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
}
