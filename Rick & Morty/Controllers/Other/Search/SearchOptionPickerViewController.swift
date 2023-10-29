//
//  SearchOptionPickerViewController.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 29.10.2023.
//

import UIKit

class SearchOptionPickerViewController: UIViewController {

  // MARK: - Properties
  private let option: SearchInputViewViewModel.DynamicOptions
  private let selectionBlock: ((String) -> Void)

  // MARK: - Subview's
  private let tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(UITableViewCell.self,
                   forCellReuseIdentifier: "cell")
    return table
  }()

  // MARK: - Init's
  init(option: SearchInputViewViewModel.DynamicOptions, selection: @escaping (String) -> Void) {
    self.option = option
    self.selectionBlock = selection
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupTableView()
  }

  // MARK: - Methods
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - UITableView Deelegate & DataSource Eextension
extension SearchOptionPickerViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return option.choises.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let choise = option.choises[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = choise.uppercased()
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let choise = option.choises[indexPath.row]
    self.selectionBlock(choise)
    dismiss(animated: true)
  }
}
