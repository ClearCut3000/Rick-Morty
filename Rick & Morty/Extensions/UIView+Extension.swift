//
//  UIView+Extension.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 08.05.2023.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }
}
