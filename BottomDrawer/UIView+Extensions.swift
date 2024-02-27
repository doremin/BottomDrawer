//
//  UIView+Extensions.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

extension UIView {
  @discardableResult
  func add(@AddBuilder _ builder: () -> [UIView]) -> UIView {
    builder().forEach { addSubview($0) }
    return self
  }
}

@resultBuilder
struct AddBuilder {
  static func buildBlock(_ views: UIView...) -> [UIView] {
    return views
  }
}

extension UIStackView {
  @discardableResult
  func arrangedAdd(@AddBuilder _ builder: () -> [UIView]) -> UIView {
    builder().forEach { addArrangedSubview($0) }
    return self
  }
}
