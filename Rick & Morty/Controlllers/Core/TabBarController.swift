//
//  TabBarController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 01.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setTabs()
  }


  // MARK: - Methods
  private func setTabs() {
    let characterViewController = CharacterViewController()
    let locationViewController = LocationViewController()
    let episodeViewController = EpisodeViewController()
    let settingsViewController = SettingsViewController()

    let navigationOne = UINavigationController(rootViewController: characterViewController)
    navigationOne.tabBarItem = UITabBarItem(title: "Characters",
                                            image: UIImage(systemName: "person.fill.questionmark"),
                                            tag: 1)
    let navigationTwo = UINavigationController(rootViewController: locationViewController)
    navigationTwo.tabBarItem = UITabBarItem(title: "Locations",
                                            image: UIImage(systemName: "location.magnifyingglass"),
                                            tag: 2)
    let navigationThree = UINavigationController(rootViewController: episodeViewController)
    navigationThree.tabBarItem = UITabBarItem(title: "Eposodes",
                                              image: UIImage(systemName: "sparkles.tv.fill"),
                                              tag: 3)
    let navigationFour = UINavigationController(rootViewController: settingsViewController)
    navigationFour.tabBarItem = UITabBarItem(title: "Settings",
                                             image: UIImage(systemName: "gearshape"),
                                             tag: 4)

    let navs = [navigationOne, navigationTwo, navigationThree, navigationFour]

    navs.forEach { nav in
      nav.navigationItem.largeTitleDisplayMode = .automatic
      nav.navigationBar.prefersLargeTitles = true
    }

    setViewControllers(navs, animated: true)
  }
}

