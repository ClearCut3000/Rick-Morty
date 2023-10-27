//
//  SearchInputView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 09.09.2023.
//

import UIKit

protocol SearchInputViewDelegate: AnyObject {
  func searchInputView(_ inputView: SearchInputView,
                       didSelectOption option: SearchInputViewViewModel.DynamicOptions)
}

final class SearchInputView: UIView {

  // MARK: - Properties
  weak var delegate: SearchInputViewDelegate?

  // MARK: - Subview's
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search"
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()

  private var viewModel: SearchInputViewViewModel? {
    didSet {
      guard let viewModel = viewModel, viewModel.hasDynamicOptions else { return }
      let options = viewModel.options
      createOptionSelectionViews(options: options)
    }
  }

  // MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(searchBar)
    addConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  public func presentKeyboard() {
    searchBar.becomeFirstResponder()
  }

  private func addConstraint() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: topAnchor),
      searchBar.leftAnchor.constraint(equalTo: leftAnchor),
      searchBar.rightAnchor.constraint(equalTo: rightAnchor),
      searchBar.heightAnchor.constraint(equalToConstant: 58)
    ])
  }

  public func configure(with viewModel: SearchInputViewViewModel) {
    searchBar.placeholder = viewModel.searchPlaceholderText
    self.viewModel = viewModel
  }

  private func createOptionSelectionViews(options: [SearchInputViewViewModel.DynamicOptions]) {
    let stackView = createOptionStackView()
    for x in 0 ..< options.count {
      let option = options[x]
      let button = createButton(with: option, tag: x)
      stackView.addArrangedSubview(button)
    }
  }

  @objc func didTapButton(_ sender: UIButton) {
    guard let options = viewModel?.options else { return }
    let tag = sender.tag
    let selected = options[tag]

    delegate?.searchInputView(self, didSelectOption: selected)
  }

  private func createOptionStackView() -> UIStackView{
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .center
    stackView.spacing = 6
    addSubviews(stackView)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      stackView.leftAnchor.constraint(equalTo: searchBar.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: searchBar.rightAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    return stackView
  }

  private func createButton(with option: SearchInputViewViewModel.DynamicOptions, tag: Int) -> UIButton {
    let button = UIButton()
    button.backgroundColor = .secondarySystemBackground
    button.setAttributedTitle(NSAttributedString(string: option.rawValue,
                                                 attributes: [
                                                  .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                  .foregroundColor: UIColor.label]),
                              for: .normal)

    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tag = tag
    button.layer.cornerRadius = 6
    return button
  }
}
