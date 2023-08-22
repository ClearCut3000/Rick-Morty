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
    List(viewModel.cellViewModel) { viewModel in
      HStack {
        if let image = viewModel.image {
          Image(uiImage: image)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .padding(8)
            .background(Color(uiColor: viewModel.iconContainerCollor))
            .cornerRadius(6)
        }
        Text(viewModel.title)
          .padding(.leading, 8)
        Spacer()
      }
      .padding(.bottom, 3)
      .onTapGesture {
        viewModel.onTapHandler(viewModel.type)
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(viewModel: .init(cellViewModel: SettingsOption.allCases.compactMap({
      SettingsCellViewModel(type: $0) { _ in }
    })))
  }
}
