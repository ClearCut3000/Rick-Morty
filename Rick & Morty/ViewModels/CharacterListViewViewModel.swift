//
//  CharacterListViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 08.05.2023.
//

import UIKit

protocol CharacterListViewViewModelDelegate: AnyObject {
  func didLoadInitialCharacters()
}

final class CharacterListViewViewModel: NSObject {

  public weak var delegate: CharacterListViewViewModelDelegate?

  private var characters: [Character] = []

  private var cellViewModels: [CharacterCollectionViewCellViewModel] = [] {
    didSet {
      characters.forEach { character in
        let viewModel = CharacterCollectionViewCellViewModel(characterName: character.name,
                                                             characterStatus: character.status,
                                                             characterImageURL: URL(string: character.image))
        cellViewModels.append(viewModel)
      }
    }
  }

  public func fetchCharacters() {
    Service.shared.execute(.listCharactersRequest,
                           expecting: GetAllCharactersResponse.self) { [weak self] result in
      switch result {
      case .success(let responseModel):
        let results = responseModel.results
        let info = responseModel.info
        self?.characters = results
        DispatchQueue.main.async {
          self?.delegate?.didLoadInitialCharacters()
        }
      case .failure(let error):
        print(String(describing: error))
      }
    }
  }
}

// MARK: - CollectionView DataSource Protocol Extension
extension CharacterListViewViewModel: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier,
                                                        for: indexPath) as? CharacterCollectionViewCell else {
      fatalError("Unsupported Cell!")
    }
    cell.configure(with: cellViewModels[indexPath.row])
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
