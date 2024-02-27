//
//  BaseViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

class BaseViewController: UIViewController {
  
  // MARK: Properties
  private var className: String {
    return type(of: self).description().components(separatedBy: ".").last ?? ""
  }
  
  // MARK: Initializer
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    addSubviews()
    setupConstraints()
  }
  
  func addSubviews() {
    // Overrride point
  }
  
  func setupConstraints() {
    // Override point
  }
}
