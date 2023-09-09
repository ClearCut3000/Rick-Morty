//
//  SettingsViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import StoreKit
import SafariServices
import SwiftUI
import UIKit

final class SettingsViewController: UIViewController {

  // MARK: - Properties
  private var settingsSUIView: UIHostingController<SettingsView>?

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Settings"
    addSUIConttroller()
  }

  // MARK: - Methods
  private func addSUIConttroller() {
    let settingsSUIView = UIHostingController(rootView:
                                                SettingsView(viewModel:
                                                              SettingsViewViewModel(cellViewModel:
                                                                                      SettingsOption.allCases.compactMap({
      return SettingsCellViewModel(type: $0) { [weak self] option in
        self?.handleTap(option: option)
      }
    }))))

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
    self.settingsSUIView = settingsSUIView
  }

  private func handleTap(option: SettingsOption) {
    guard Thread.current.isMainThread else {
      return
    }
    if let url = option.targetURL {
      let safaryVC = SFSafariViewController(url: url)
      present(safaryVC, animated: true)
    } else if option == .rateApp {
      if let windowScene = view.window?.windowScene {
        SKStoreReviewController.requestReview(in: windowScene)
      }
    }
  }
}
