//
//  CharacterListViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 08.05.2023.
//

import UIKit

final class CharacterListViewViewModel: NSObject {
  func fetchCharacters() {
    
  }
}

// MARK: - CollectionView DataSource Protocol Extension
extension CharacterListViewViewModel: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier,
                                                  for: indexPath) as? CharacterCollectionViewCell else {
      fatalError("Unsupported Cell!")
    }
    let viewModel = CharacterCollectionViewCellViewModel(characterName: "Some",
                                                         characterStatus: .alive,
                                                         characterImageURL: nil)
    cell.configure(with: viewModel)
    return cell
  }
}

//MARK: - CollectionView Delegate Protocol Extension
extension CharacterListViewViewModel: UICollectionViewDelegate {

}

//MARK: - CollectionView FlowLayout Protocol Extension
extension CharacterListViewViewModel: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width - 30) / 2
    return CGSize(width: width, height: width * 1.5)
  }
}
