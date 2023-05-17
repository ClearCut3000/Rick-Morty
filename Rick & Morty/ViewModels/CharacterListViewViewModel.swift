//
//  CharacterListViewViewModel.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 08.05.2023.
//

import UIKit

protocol CharacterListViewViewModelDelegate: AnyObject {
  func didLoadInitialCharacters()
  func didSelectCharacter(_ character: Character)
}

/// View Model to handle character list view logic
final class CharacterListViewViewModel: NSObject {

  // MARK: - ViewModel Properties
  public weak var delegate: CharacterListViewViewModelDelegate?

  public var shouldShowLoadMoreIndicator: Bool {
    return apiInfo?.next != nil
  }

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

  private var apiInfo: Info? = nil


  // MARK: - ViewModel Methods
  /// Sets initial amount of characters(20)
  public func fetchCharacters() {
    Service.shared.execute(.listCharactersRequest,
                           expecting: GetAllCharactersResponse.self) { [weak self] result in
      switch result {
      case .success(let responseModel):
        let results = responseModel.results
        let info = responseModel.info
        self?.characters = results
        self?.apiInfo = info
        DispatchQueue.main.async {
          self?.delegate?.didLoadInitialCharacters()
        }
      case .failure(let error):
        print(String(describing: error))
      }
    }
  }

  /// Paginate if additional characters  are needed
  public func fetchAdditionalCharacters() {

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

// MARK: - CollectionView Delegate Protocol Extension
extension CharacterListViewViewModel: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let character = characters[indexPath.row]
    delegate?.didSelectCharacter(character)
  }
}

// MARK: - CollectionView FlowLayout Protocol Extension
extension CharacterListViewViewModel: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width - 30) / 2
    return CGSize(width: width, height: width * 1.5)
  }
}

// MARK: - ScrollViewDelegate Protocol Extension
extension CharacterListViewViewModel: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldShowLoadMoreIndicator else { return }

  }
}
