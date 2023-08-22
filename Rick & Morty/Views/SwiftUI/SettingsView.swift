//
//  SettingsView.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 21.08.2023.
//

import SwiftUI

struct SettingsView: View {

  // MARK: - Properties
  var viewModel: SettingsViewViewModel

  // MARK: - Init
  init(viewModel: SettingsViewViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - View Body
  var body: some View {
    List(viewModel.cellViewModel) { model in
      HStack {
        if let image = model.image {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .padding()
        }
        Text(model.title)
      }
      .padding()
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(viewModel: .init(cellViewModel: SettingsOption.allCases.compactMap({
      SettingsCellViewModel(type: $0)
    })))
  }
}
