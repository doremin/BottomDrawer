//
//  SettingsViewController.swift
//  BottomDrawer
//
//  Created by doremin on 2/28/24.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
  func settingsViewControllerDidTapped()
  func settingsViewControllerDragged(_ sender: UIPanGestureRecognizer)
}

final class SettingsViewController: BaseViewController {
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Settings"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isUserInteractionEnabled = true
    return label
  }()
  
  weak var delegate: SettingsViewControllerDelegate?
  
  var isOpened = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemYellow
    setUpGesture()
  }
  
  private func setUpGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelDidTapped))
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(titleLabelDidDragged))
    titleLabel.addGestureRecognizer(tapGesture)
    titleLabel.addGestureRecognizer(panGesture)
  }
  
  @objc func titleLabelDidDragged(_ sender: UIPanGestureRecognizer) {
    delegate?.settingsViewControllerDragged(sender)
  }
  
  @objc func titleLabelDidTapped() {
    delegate?.settingsViewControllerDidTapped()
  }
  
  override func addSubviews() {
    view.add {
      titleLabel
    }
  }
  
  override func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      titleLabel.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}

#Preview {
  return SettingsViewController()
}
