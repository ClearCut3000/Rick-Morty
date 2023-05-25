//
//  CharacterDetailViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 17.05.2023.
//

import Foundation
import UIKit

final class CharacterDetailViewViewModel {

  // MARK: - Properties
  private let character: Character
  public var title: String {
    character.name.uppercased()
  }
  private var requestURL: URL? {
    return URL(string: character.url)
  }
  enum SectionType {
    case photo(viewModel: CharacterPhotoCollectionViewCellViewModel)
    case information(viewModel: [CharacterInfoCollectionViewCellViewModel])
    case episodes(viewModel: [CharacterEpisodeCollectionViewCellViewModel])
  }
  public var sections: [SectionType] = []

  //MARK: - Init
  init(character: Character) {
    self.character = character
    setupSections()
  }

  // MARK: - Methods
  private func setupSections() {
    sections = [
      .photo(viewModel: .init(imageURL: URL(string: character.image))),
      .information(viewModel: [
        .init(value: character.status.text, title: "Status"),
        .init(value: character.gender.rawValue, title: "Gender"),
        .init(value: character.type, title: "Type"),
        .init(value: character.species, title: "Species"),
        .init(value: character.origin.name, title: "Origin"),
        .init(value: character.location.name, title: "Location"),
        .init(value: character.created, title: "Created"),
        .init(value: "\(character.episode.count)", title: "Total Episodes "),
      ]),
      .episodes(viewModel: character.episode.compactMap {
        return CharacterEpisodeCollectionViewCellViewModel(episodeDataURL: URL(string: $0))
      })
    ]
  }
  /// Photo
  public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                 leading: 0,
                                                 bottom: 10,
                                                 trailing: 0)
    let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                    heightDimension: .fractionalHeight(0.5)),
                                                 subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    return section
  }

  /// Info
  public func createInfoSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                         heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                 leading: 2,
                                                 bottom: 2,
                                                 trailing: 2)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                      heightDimension: .absolute(150)),
                                                   subitems: [item, item])
    let section = NSCollectionLayoutSection(group: group)
    return section
  }

  /// Episodes
  public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                 leading: 10,
                                                 bottom: 10,
                                                 trailing: 10)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                                                      heightDimension: .absolute(0.5)),
                                                   subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    return section
  }
}
